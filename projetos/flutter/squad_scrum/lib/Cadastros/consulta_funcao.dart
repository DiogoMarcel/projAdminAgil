import 'dart:convert';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:squad_scrum/Cadastros/cadastro_funcao.dart';
import 'package:squad_scrum/Consts/consts.dart';
import 'package:squad_scrum/Enumeradores/enumeradores.dart';
import 'package:squad_scrum/EntidadePostgres/funcao_dao.dart';
import 'package:squad_scrum/Widgets/base_consulta.dart';
import 'package:squad_scrum/util/util_http.dart' as util_http;

class ConsultaFuncao extends StatefulWidget {
  const ConsultaFuncao({Key? key}) : super(key: key);

  @override
  State<ConsultaFuncao> createState() => _ConsultaFuncaoState();
}

class _ConsultaFuncaoState extends State<ConsultaFuncao> {
  List<FuncaoDAO> listaFuncao = [];
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
          "Descrição",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        onSort: onSort,
        size: ColumnSize.M,
      ),
      const DataColumn2(label: Text(""), size: ColumnSize.S),
      const DataColumn2(label: Text(""), size: ColumnSize.S),
    ];
  }

  void onSort(int columnIndex, bool ascending) {
    sortColumnIndex = columnIndex;
    sortAscending = ascending;

    setState(() {
      if (sortColumnIndex == 0) {
        if (sortAscending) {
          listaFuncao.sort((a, b) {
            return b.idFuncao!.compareTo(a.idFuncao!);
          });
        } else {
          listaFuncao.sort((a, b) {
            return a.idFuncao!.compareTo(b.idFuncao!);
          });
        }
      } else if (sortColumnIndex == 1) {
        if (sortAscending) {
          listaFuncao.sort((a, b) {
            return b.descricao.compareTo(a.descricao);
          });
        } else {
          listaFuncao.sort((a, b) {
            return a.descricao.compareTo(b.descricao);
          });
        }
      }
    });
  }

  List<DataRow> listaDataRow() {
    return listaFuncao
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
                if (listaFuncao.indexOf(e).isEven) {
                  return Colors.grey.withOpacity(0.3);
                }
                return null;
              },
            ),
            cells: [
              DataCell(Text(e.idFuncao.toString())),
              DataCell(Text(e.descricao)),
              DataCell(
                IconButton(
                  tooltip: "Editar",
                  icon: const Icon(
                    Icons.edit,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    onButtonAlterar(context, listaFuncao.indexOf(e));
                  },
                ),
              ),
              DataCell(
                IconButton(
                  tooltip: "Excluir",
                  icon: const Icon(
                    Icons.delete,
                    color: Colors.red,
                  ),
                  onPressed: () {
                    onButtonDeletar(listaFuncao.indexOf(e));
                  },
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
      tituloTela: "Consulta Funcao",
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
        return const CadastroFuncao(
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
        return CadastroFuncao(
          tipoCrud: TipoCrud.alterar,
          funcaoAlterar: listaFuncao[index],
        );
      }),
    ).then((value) async {
      await carregarTodosRegistros();
    });
  }

  void onButtonDeletar(int index) async {
    await util_http.delete(
      path: rotaFuncao,
      jsonDAO: jsonEncode(listaFuncao[index].toJson()),
      context: context,
    );
    listaFuncao.removeAt(index);
    setState(() {});
  }

  Future<void> carregarTodosRegistros() async {
    listaFuncao.clear();
    var json = await util_http.get(path: rotaFuncao, context: context);
    listaFuncao =
        List<FuncaoDAO>.from(json.map((json) => FuncaoDAO.fromJson(json)));
    setState(() {});
  }
}
