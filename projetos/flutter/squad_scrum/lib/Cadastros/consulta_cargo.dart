import 'dart:convert';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:squad_scrum/Cadastros/cadastro_cargo.dart';
import 'package:squad_scrum/Consts/consts.dart';
import 'package:squad_scrum/Enumeradores/enumeradores.dart';
import 'package:squad_scrum/EntidadePostgres/cargo_dao.dart';
import 'package:squad_scrum/Widgets/base_consulta.dart';
import 'package:squad_scrum/util/util_http.dart' as http_util;

class ConsultaCargo extends StatefulWidget {
  const ConsultaCargo({Key? key}) : super(key: key);

  @override
  State<ConsultaCargo> createState() => _ConsultaCargoState();
}

class _ConsultaCargoState extends State<ConsultaCargo> {
  List<CargoDAO> listaCargo = [];
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
        size: ColumnSize.S,
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
          listaCargo.sort((a, b) {
            return b.idCargo!.compareTo(a.idCargo!);
          });
        } else {
          listaCargo.sort((a, b) {
            return a.idCargo!.compareTo(b.idCargo!);
          });
        }
      } else if (sortColumnIndex == 1) {
        if (sortAscending) {
          listaCargo.sort((a, b) {
            return b.descricao.compareTo(a.descricao);
          });
        } else {
          listaCargo.sort((a, b) {
            return a.descricao.compareTo(b.descricao);
          });
        }
      }
    });
  }

  List<DataRow> listaDataRow() {
    return listaCargo
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
                if (listaCargo.indexOf(e).isEven) {
                  return Colors.grey.withOpacity(0.3);
                }
                return null;
              },
            ),
            cells: [
              DataCell(Text(e.idCargo.toString())),
              DataCell(Text(e.descricao)),
              DataCell(
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        onButtonAlterar(context, listaCargo.indexOf(e));
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
                        onButtonDeletar(listaCargo.indexOf(e));
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
      tituloTela: "Consulta Cargo",
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
        return const CadastroCargo(
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
        return CadastroCargo(
          tipoCrud: TipoCrud.alterar,
          cargoAlterar: listaCargo[index],
        );
      }),
    ).then(
      (value) async {
        await carregarTodosRegistros();
      },
    );
  }

  void onButtonDeletar(int index) async {
    await http_util.delete(
      path: rotaCargo,
      jsonDAO: jsonEncode(listaCargo[index].toJson()),
      context: context,
    );
    listaCargo.removeAt(index);
    setState(() {});
  }

  Future<void> carregarTodosRegistros() async {
    listaCargo.clear();
    var json = await http_util.get(path: rotaCargo, context: context);
    listaCargo =
        List<CargoDAO>.from(json.map((json) => CargoDAO.fromJson(json)));
    setState(() {});
  }
}
