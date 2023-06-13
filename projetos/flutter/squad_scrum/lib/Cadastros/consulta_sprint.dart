import 'dart:convert';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:search_choices/search_choices.dart';
import 'package:squad_scrum/Cadastros/cadastro_sprint.dart';
import 'package:squad_scrum/Consts/consts.dart';
import 'package:squad_scrum/EntidadePostgres/pesquisa_dao.dart';
import 'package:squad_scrum/EntidadePostgres/sprint_dao.dart';
import 'package:squad_scrum/EntidadePostgres/sprint_pesquisa_dao.dart';
import 'package:squad_scrum/Enumeradores/enumeradores.dart';
import 'package:intl/intl.dart';
import 'package:squad_scrum/Widgets/base_consulta.dart';
import 'package:squad_scrum/util/util_http.dart' as util_http;

class ConsultaSprint extends StatefulWidget {
  const ConsultaSprint({Key? key}) : super(key: key);

  @override
  State<ConsultaSprint> createState() => _ConsultaSprintState();
}

class _ConsultaSprintState extends State<ConsultaSprint> {
  List<SprintDAO> listaSprint = [];
  List<PesquisaDAO> listaPesquisa = [];
  List<DropdownMenuItem> items = [];
  bool sortAscending = false;
  int? sortColumnIndex;

  List<DataColumn> listaDataColumn() {
    return [
      DataColumn2(
        label: const Text(
          "Código",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        onSort: onSort,
        size: ColumnSize.S,
      ),
      DataColumn2(
        label: const Text(
          "Nome",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        onSort: onSort,
        size: ColumnSize.M,
      ),
      DataColumn2(
        label: const Text(
          "Data Inicial",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        onSort: onSort,
        size: ColumnSize.M,
      ),
      DataColumn2(
        label: const Text(
          "Data Final",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        onSort: onSort,
        size: ColumnSize.M,
      ),
      const DataColumn2(
        label: Text(
          "Pesquisa",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        size: ColumnSize.L,
      ),
      const DataColumn2(
        label: Text(""),
        size: ColumnSize.M,
      ),
    ];
  }

  void onSort(int columnIndex, bool ascending) {
    sortColumnIndex = columnIndex;
    sortAscending = ascending;

    setState(() {
      if (sortColumnIndex == 0) {
        if (sortAscending) {
          listaSprint.sort((a, b) {
            return b.idSprint!.compareTo(a.idSprint!);
          });
        } else {
          listaSprint.sort((a, b) {
            return a.idSprint!.compareTo(b.idSprint!);
          });
        }
      } else if (sortColumnIndex == 1) {
        if (sortAscending) {
          listaSprint.sort((a, b) {
            return b.nome.compareTo(a.nome);
          });
        } else {
          listaSprint.sort((a, b) {
            return a.nome.compareTo(b.nome);
          });
        }
      } else if (sortColumnIndex == 2) {
        if (sortAscending) {
          listaSprint.sort((a, b) {
            return b.dataInicio.compareTo(a.dataInicio);
          });
        } else {
          listaSprint.sort((a, b) {
            return a.dataInicio.compareTo(b.dataInicio);
          });
        }
      } else if (sortColumnIndex == 3) {
        if (sortAscending) {
          listaSprint.sort((a, b) {
            return b.dataFinal.compareTo(a.dataFinal);
          });
        } else {
          listaSprint.sort((a, b) {
            return a.dataFinal.compareTo(b.dataFinal);
          });
        }
      }
    });
  }

  List<DataRow> listaDataRow() {
    return listaSprint
        .map(
          (e) => DataRow2(
            color: MaterialStateProperty.resolveWith<Color?>(
              (Set<MaterialState> states) {
                if (states.contains(MaterialState.selected)) {
                  return Theme.of(context)
                      .colorScheme
                      .primary
                      .withOpacity(0.08);
                }
                if (listaSprint.indexOf(e).isEven) {
                  return Colors.grey.withOpacity(0.3);
                }
                return null;
              },
            ),
            cells: [
              DataCell(Text(e.idSprint.toString())),
              DataCell(Text(e.nome)),
              DataCell(Text(DateFormat("dd/MM/yyyy").format(e.dataInicio))),
              DataCell(Text(DateFormat("dd/MM/yyyy").format(e.dataFinal))),
              DataCell(
                Tooltip(
                  message: getMensagemTooltip(e.pesquisaDAO!),
                  child: SearchChoices.single(
                    hint: " ",
                    style: const TextStyle(
                      fontSize: 15,
                      color: Colors.black,
                    ),
                    underline: Container(
                      height: 0,
                    ),
                    searchInputDecoration: const InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    isExpanded: true,
                    padding: const EdgeInsets.all(0),
                    items: items,
                    value: e.pesquisaDAO!.idPesquisa,
                    onChanged: (value) async {
                      if(value == null){
                        e.pesquisaDAO!.idPesquisa = null;
                        await util_http.delete(
                          path: rotaSprintPesquisa,
                          jsonDAO: jsonEncode(e.pesquisaDAO!.toJson()),
                          context: context,
                        );
                        e.pesquisaDAO!.idSprintPesquisa = 0;
                        e.pesquisaDAO!.idSprint = 0;
                      } else {
                        e.pesquisaDAO!.idPesquisa = int.parse(value.toString().split('-')[0]);
                        e.pesquisaDAO!.idSprint = e.idSprint!;

                        var response = await util_http.post(
                          path: rotaSprintPesquisa,
                          jsonDAO: jsonEncode(e.pesquisaDAO!.toJson()),
                          context: context,
                        );
                        e.pesquisaDAO!.idSprintPesquisa = response["insertId"];
                      }
                      setState(() {});
                    },
                  ),
                ),
              ),
              DataCell(
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        onButtonAlterar(context, listaSprint.indexOf(e));
                      },
                      icon: const Icon(
                        Icons.edit,
                      ),
                    ),
                    const SizedBox(
                      width: 30,
                    ),
                    IconButton(
                      onPressed: () {
                        onButtonDeletar(listaSprint.indexOf(e));
                      },
                      icon: const Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ).toList();
  }

  String getMensagemTooltip(SprintPesquisaDAO sprintPesquisaDAO){
    var listafiltrada = listaPesquisa.where((element) {
      return element.idPesquisa == sprintPesquisaDAO.idPesquisa;
    }).toList();

    if(listafiltrada.isNotEmpty){
      return listafiltrada[0].titulo;
    } else {
      return "";
    }
  }

  @override
  void initState() {
    super.initState();
    carregarItemsPesquisa();
    carregarTodosRegistros();
  }

  @override
  Widget build(BuildContext context) {
    return BaseConsulta(
      tituloTela: "Consulta Sprint",
      onButtonInserir: onButtonInserir,
      listaDataColumn: listaDataColumn(),
      listaDataRow: listaDataRow(),
      sortAscending: sortAscending,
      sortColumnIndex: sortColumnIndex,
    );
  }

  void onButtonInserir() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) {
        return const CadastroSprint(
          tipoCrud: TipoCrud.inserir,
        );
      }),
    ).then((value) async {
      await carregarTodosRegistros();
    });
  }

  void onButtonAlterar(BuildContext context, int index) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) {
        return CadastroSprint(
          tipoCrud: TipoCrud.alterar,
          sprintAlterar: listaSprint[index],
        );
      }),
    ).then((value) async {
      await carregarTodosRegistros();
    });
  }

  void onButtonDeletar(int index) async {
    await util_http.delete(
      path: rotaSprint,
      jsonDAO: jsonEncode(listaSprint[index].toJson()),
      context: context,
    );
    listaSprint.removeAt(index);
    setState(() {});
  }

  Future<void> carregarItemsPesquisa() async {
    listaPesquisa.clear();
    var json = await util_http.get(path: rotaPesquisa, context: context);
    listaPesquisa = List<PesquisaDAO>.from(json.map((json) => PesquisaDAO.fromJson(json)));

    listaPesquisa.forEach(
          (element) {
        items.add(
          DropdownMenuItem(
            value: element.idPesquisa,
            child: Text(
              "${element.idPesquisa} - ${element.titulo}",
              overflow: TextOverflow.ellipsis,
            ),
          ),
        );
      },
    );
    setState(() {});
  }

  Future<void> carregarTodosRegistros() async {
    listaSprint.clear();
    var json = await util_http.get(path: rotaSprint, context: context);
    listaSprint = List<SprintDAO>.from(json.map((json) => SprintDAO.fromJson(json)));
    setState(() {});
  }
}
