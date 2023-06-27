import 'dart:convert';
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
      DataColumn(
        label: const Text(
          "Id",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        onSort: onSort,
      ),
      DataColumn(
        label: const Text(
          "Título",
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

  @override
  void initState() {
    super.initState();
    carregarTodosRegistros();
  }

  @override
  Widget build(BuildContext context) {
    return BaseConsulta(
      listaDataColumn: listaDataColumn(),
      listaDados: listaPesquisa,
      processarColunas: (value){
        return [
          DataCell(Text(value.idPesquisa.toString())),
          DataCell(Text(value.titulo)),
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
        return const CadastroPesquisa(
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
    listaPesquisa = List<PesquisaDAO>.from(json.map((json) => PesquisaDAO.fromJson(json)));
    setState(() {});
  }
}
