import 'dart:convert';
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
      DataColumn(
        label: const Text(
          "Id",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        onSort: onSort,
      ),
      DataColumn(
        label: const Text(
          "Nome",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        onSort: onSort,
      ),
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

  @override
  void initState() {
    super.initState();
    carregarTodosRegistros();
  }

  @override
  Widget build(BuildContext context) {
    return BaseConsulta(
      listaDataColumn: listaDataColumn(),
      listaDados: listaEmpresa,
      processarColunas: (value){
        return [
          DataCell(Text(value.idEmpresa.toString())),
          DataCell(Text(value.nome)),
        ];
      },
      onButtonInserir: onButtonInserir,
      onAlterar: onButtonAlterar,
      onDeletar: onButtonDeletar,
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

  void onButtonAlterar(int index) {
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

    listaEmpresa = List<EmpresaDAO>.from(json.map((json) => EmpresaDAO.fromJson(json)));
    setState(() {});
  }
}
