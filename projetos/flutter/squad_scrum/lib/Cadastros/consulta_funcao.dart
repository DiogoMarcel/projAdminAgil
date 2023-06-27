import 'dart:convert';
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
      DataColumn(
        label: const Text(
          "Id",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        onSort: onSort,
      ),
      DataColumn(
        label: const Text(
          "Descrição",
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

  @override
  void initState() {
    super.initState();
    carregarTodosRegistros();
  }

  @override
  Widget build(BuildContext context) {
    return BaseConsulta(
      listaDataColumn: listaDataColumn(),
      listaDados: listaFuncao,
      processarColunas: (value){
        return [
          DataCell(Text(value.idFuncao.toString())),
          DataCell(Text(value.descricao)),
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
        return const CadastroFuncao(
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
