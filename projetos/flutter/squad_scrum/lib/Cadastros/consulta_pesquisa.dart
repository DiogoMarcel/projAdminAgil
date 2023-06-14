import 'dart:convert';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:squad_scrum/Cadastros/cadastro_pesquisa.dart';
import 'package:squad_scrum/Consts/consts.dart';
import 'package:squad_scrum/EntidadePostgres/pesquisa_dao.dart';
import 'package:squad_scrum/Enumeradores/enumeradores.dart';
import 'package:squad_scrum/Widgets/base_consulta.dart';
import 'package:squad_scrum/util/util_http.dart' as util_http;

class ConsultaPesquisa extends StatefulWidget {
  const ConsultaPesquisa({Key? key}) : super(key: key);

  @override
  State<ConsultaPesquisa> createState() => _ConsultaPesquisaState();
}

class _ConsultaPesquisaState extends State<ConsultaPesquisa> {
  List<PesquisaDAO> listaPesquisa = [];
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
          "Título",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        onSort: onSort,
        size: ColumnSize.M,
      ),
      const DataColumn2(label: Text(""), size: ColumnSize.S),
    ];
  }

  void onSort(int columnIndex, bool ascending) {
    sortColumnIndex = columnIndex;
    sortAscending = ascending;

    setState(() {
      if (sortColumnIndex == 0) {
        if (sortAscending) {
          listaPesquisa.sort((a, b) {
            return b.idPesquisa!.compareTo(a.idPesquisa!);
          });
        } else {
          listaPesquisa.sort((a, b) {
            return a.idPesquisa!.compareTo(b.idPesquisa!);
          });
        }
      } else if (sortColumnIndex == 1) {
        if (sortAscending) {
          listaPesquisa.sort((a, b) {
            return b.titulo.compareTo(a.titulo);
          });
        } else {
          listaPesquisa.sort((a, b) {
            return a.titulo.compareTo(b.titulo);
          });
        }
      }
    });
  }

  List<DataRow> listaDataRow() {
    return listaPesquisa
        .map(
          (e) => DataRow2(
            color: MaterialStateProperty.resolveWith<Color?>(
              (Set<MaterialState> states) {
                if (states.contains(MaterialState.selected)) {
                  return Theme.of(context).colorScheme.primary.withOpacity(0.08);
                }
                if (listaPesquisa.indexOf(e).isEven) {
                  return Colors.grey.withOpacity(0.3);
                }
                return null;
              },
            ),
            cells: [
              DataCell(Text(e.idPesquisa.toString())),
              DataCell(Text(e.titulo)),
              DataCell(
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        onButtonAlterar(context, listaPesquisa.indexOf(e));
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
                        onButtonDeletar(listaPesquisa.indexOf(e));
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
      tituloTela: "Consulta Pesquisa",
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
        return const CadastroPesquisa(
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
        return CadastroPesquisa(
          tipoCrud: TipoCrud.alterar,
          pesquisaAlterar: listaPesquisa[index],
        );
      }),
    ).then((value) async {
      await carregarTodosRegistros();
    });
  }

  void onButtonDeletar(int index) async {
    await util_http.delete(
      path: rotaPesquisa,
      jsonDAO: jsonEncode(listaPesquisa[index].toJson()),
      context: context,
    );
    listaPesquisa.removeAt(index);
    setState(() {});
  }

  Future<void> carregarTodosRegistros() async {
    listaPesquisa.clear();
    var json = await util_http.get(path: rotaPesquisa, context: context);
    listaPesquisa =
        List<PesquisaDAO>.from(json.map((json) => PesquisaDAO.fromJson(json)));
    setState(() {});
  }
}
