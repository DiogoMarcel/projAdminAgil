import 'dart:convert';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:squad_scrum/Cadastros/cadastro_colaborador.dart';
import 'package:squad_scrum/Consts/consts.dart';
import 'package:squad_scrum/Enumeradores/enumeradores.dart';
import 'package:squad_scrum/EntidadePostgres/colaborador_dao.dart';
import 'package:squad_scrum/Widgets/base_consulta.dart';
import 'package:squad_scrum/util/util_http.dart' as util_http;

class ConsultaColaborador extends StatefulWidget {
  const ConsultaColaborador({Key? key}) : super(key: key);

  @override
  State<ConsultaColaborador> createState() => _ConsultaColaboradorState();
}

class _ConsultaColaboradorState extends State<ConsultaColaborador> {
  List<ColaboradorDAO> listaColaborador = [];
  bool sortAscending = false;
  int? sortColumnIndex;

  List<DataColumn> listaDataColumn() {
    return [
      DataColumn2(
        label: const Text(
          "Id",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        onSort: onSort,
        size: ColumnSize.S,
      ),
      DataColumn2(
        label: const Text(
          "Usuário",
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
        size: ColumnSize.S,
      ),
      const DataColumn2(label: Text(""), size: ColumnSize.S),
    ];
  }

  void onSort(int columnIndex, bool ascending) {
    sortColumnIndex = columnIndex;
    sortAscending = ascending;

    setState(
      () {
        if (sortColumnIndex == 0) {
          if (sortAscending) {
            listaColaborador.sort((a, b) {
              return b.idColaborador!.compareTo(a.idColaborador!);
            });
          } else {
            listaColaborador.sort((a, b) {
              return a.idColaborador!.compareTo(b.idColaborador!);
            });
          }
        } else if (sortColumnIndex == 1) {
          if (sortAscending) {
            listaColaborador.sort((a, b) {
              return b.usuario.compareTo(a.usuario);
            });
          } else {
            listaColaborador.sort((a, b) {
              return a.usuario.compareTo(b.usuario);
            });
          }
        } else if (sortColumnIndex == 2) {
          if (sortAscending) {
            listaColaborador.sort((a, b) {
              return b.nome.compareTo(a.nome);
            });
          } else {
            listaColaborador.sort((a, b) {
              return a.nome.compareTo(b.nome);
            });
          }
        }
      },
    );
  }

  List<DataRow> listaDataRow() {
    return listaColaborador
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
                if (listaColaborador.indexOf(e).isEven) {
                  return Colors.grey.withOpacity(0.3);
                }
                return null;
              },
            ),
            cells: [
              DataCell(Text(e.idColaborador.toString())),
              DataCell(Text(e.usuario)),
              DataCell(Text(e.nome)),
              DataCell(
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        onButtonAlterar(context, listaColaborador.indexOf(e));
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
                        onButtonDeletar(listaColaborador.indexOf(e));
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
        )
        .toList();
  }

  @override
  void initState() {
    super.initState();
    carregarTodosRegistros();
  }

  @override
  Widget build(BuildContext context) {
    return BaseConsulta(
      tituloTela: "Consulta Colaborador",
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
        return const CadastroColaborador(
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
        return CadastroColaborador(
          tipoCrud: TipoCrud.alterar,
          colaboradorAlterar: listaColaborador[index],
        );
      }),
    ).then((value) async {
      await carregarTodosRegistros();
    });
  }

  void onButtonDeletar(int index) async {
    await util_http.delete(
      path: rotaColaborador,
      jsonDAO: jsonEncode(listaColaborador[index].toJson()),
      context: context,
    );
    listaColaborador.removeAt(index);
    setState(() {});
  }

  Future<void> carregarTodosRegistros() async {
    listaColaborador.clear();
    var json = await util_http.get(path: rotaColaborador, context: context);
    listaColaborador = List<ColaboradorDAO>.from(
        json.map((json) => ColaboradorDAO.fromJson(json)));
    setState(() {});
  }
}
