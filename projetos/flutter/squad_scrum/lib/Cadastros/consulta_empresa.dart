import 'dart:convert';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:squad_scrum/Cadastros/cadastro_empresa.dart';
import 'package:squad_scrum/Enumeradores/enumeradores.dart';
import 'package:squad_scrum/EntidadePostgres/empresa_dao.dart';
import 'package:squad_scrum/Consts/consts.dart';
import 'package:squad_scrum/Widgets/base_consulta.dart';
import 'package:squad_scrum/util/util_http.dart' as util_http;

class ConsultaEmpresa extends StatefulWidget {
  const ConsultaEmpresa({Key? key}) : super(key: key);

  @override
  State<ConsultaEmpresa> createState() => _ConsultaEmpresaState();
}

class _ConsultaEmpresaState extends State<ConsultaEmpresa> {
  List<EmpresaDAO> listaEmpresa = [];
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
          listaEmpresa.sort((a, b) {
            return b.idEmpresa!.compareTo(a.idEmpresa!);
          });
        } else {
          listaEmpresa.sort((a, b) {
            return a.idEmpresa!.compareTo(b.idEmpresa!);
          });
        }
      } else if (sortColumnIndex == 1) {
        if (sortAscending) {
          listaEmpresa.sort((a, b) {
            return b.nome.compareTo(a.nome);
          });
        } else {
          listaEmpresa.sort((a, b) {
            return a.nome.compareTo(b.nome);
          });
        }
      }
    });
  }

  List<DataRow> listaDataRow() {
    return listaEmpresa
        .map(
          (e) => DataRow2(
            color: MaterialStateProperty.resolveWith<Color?>(
              (Set<MaterialState> states) {
                if (states.contains(MaterialState.selected)) {
                  return Theme.of(context).colorScheme.primary.withOpacity(0.08);
                }
                if (listaEmpresa.indexOf(e).isEven) {
                  return Colors.grey.withOpacity(0.3);
                }
                return null;
              },
            ),
            cells: [
              DataCell(Text(e.idEmpresa.toString())),
              DataCell(Text(e.nome)),
              DataCell(
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        onButtonAlterar(context, listaEmpresa.indexOf(e));
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
                        onButtonDeletar(listaEmpresa.indexOf(e));
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
      tituloTela: "Consulta Empresa",
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
        return const CadastroEmpresa(
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
        return CadastroEmpresa(
          tipoCrud: TipoCrud.alterar,
          empresaAlterar: listaEmpresa[index],
        );
      }),
    ).then(
      (value) async {
        await carregarTodosRegistros();
      },
    );
  }

  void onButtonDeletar(int index) async {
    await util_http.delete(
      path: rotaEmpresa,
      jsonDAO: jsonEncode(listaEmpresa[index].toJson()),
      context: context,
    );
    listaEmpresa.removeAt(index);
    setState(() {});
  }

  Future<void> carregarTodosRegistros() async {
    listaEmpresa.clear();
    var json = await util_http.get(path: rotaEmpresa, context: context);

    listaEmpresa =
        List<EmpresaDAO>.from(json.map((json) => EmpresaDAO.fromJson(json)));
    setState(() {});
  }
}
