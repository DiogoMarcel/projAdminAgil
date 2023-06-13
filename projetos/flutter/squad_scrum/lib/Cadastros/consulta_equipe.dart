import 'dart:convert';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:squad_scrum/Cadastros/cadastro_equipe.dart';
import 'package:squad_scrum/Consts/consts.dart';
import 'package:squad_scrum/Enumeradores/enumeradores.dart';
import 'package:squad_scrum/EntidadePostgres/equipe_dao.dart';
import 'package:squad_scrum/Widgets/base_consulta.dart';
import 'package:squad_scrum/util/util_http.dart' as util_http;

class ConsultaEquipe extends StatefulWidget {
  const ConsultaEquipe({Key? key}) : super(key: key);

  @override
  State<ConsultaEquipe> createState() => _ConsultaEquipeState();
}

class _ConsultaEquipeState extends State<ConsultaEquipe> {
  List<EquipeDAO> listaEquipe = [];
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
          "Nome",
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
          listaEquipe.sort((a, b) {
            return b.idEquipe!.compareTo(a.idEquipe!);
          });
        } else {
          listaEquipe.sort((a, b) {
            return a.idEquipe!.compareTo(b.idEquipe!);
          });
        }
      } else if (sortColumnIndex == 1) {
        if (sortAscending) {
          listaEquipe.sort((a, b) {
            return b.nome.compareTo(a.nome);
          });
        } else {
          listaEquipe.sort((a, b) {
            return a.nome.compareTo(b.nome);
          });
        }
      }
    });
  }

  List<DataRow> listaDataRow() {
    return listaEquipe
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
                if (listaEquipe.indexOf(e).isEven) {
                  return Colors.grey.withOpacity(0.3);
                }
                return null;
              },
            ),
            cells: [
              DataCell(Text(e.idEquipe.toString())),
              DataCell(Text(e.nome)),
              DataCell(
                IconButton(
                  tooltip: "Editar",
                  icon: const Icon(
                    Icons.edit,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    onButtonAlterar(context, listaEquipe.indexOf(e));
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
                    onButtonDeletar(listaEquipe.indexOf(e));
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
      tituloTela: "Consulta Equipe",
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
        return const CadastroEquipe(
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
        return CadastroEquipe(
          tipoCrud: TipoCrud.alterar,
          equipeAlterar: listaEquipe[index],
        );
      }),
    ).then((value) async {
      await carregarTodosRegistros();
    });
  }

  void onButtonDeletar(int index) async {
    await util_http.delete(
      path: rotaEquipe,
      jsonDAO: jsonEncode(listaEquipe[index].toJson()),
      context: context,
    );
    listaEquipe.removeAt(index);
    setState(() {});
  }

  Future<void> carregarTodosRegistros() async {
    listaEquipe.clear();
    var json = await util_http.get(path: rotaEquipe, context: context);
    listaEquipe =
        List<EquipeDAO>.from(json.map((json) => EquipeDAO.fromJson(json)));
    setState(() {});
  }
}
