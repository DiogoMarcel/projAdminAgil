import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:squad_scrum/BaseWidget/base_state_consulta.dart';
import 'package:squad_scrum/Cadastros/inclusao_pesquisa.dart';
import 'package:squad_scrum/Consts/consts.dart';
import 'package:squad_scrum/EntidadePostgres/pesquisa_dao.dart';
import 'package:squad_scrum/Enumeradores/enumeradores.dart';
import 'package:squad_scrum/util/util_http.dart' as util_http;

class ConsultaPesquisa extends StatefulWidget {
  const ConsultaPesquisa({Key? key}) : super(key: key);

  @override
  BaseStateConsulta<ConsultaPesquisa> createState() => _EquipeState();
}

class _EquipeState extends BaseStateConsulta<ConsultaPesquisa> {
  List<PesquisaDAO> listaPesquisa = [];

  @override
  void initState() {
    super.tituloTela = "Consulta Pesquisa";
    super.initState();
  }

  @override
  void onInserir() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) {
        return const InclusaoPesquisa(
          tipoCrud: TipoCrud.inserir,
        );
      }),
    ).then((value) async {
      await carregarTodosRegistros();
    });
  }

  @override
  void onAlterar(BuildContext context, int index) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) {
        return InclusaoPesquisa(
          tipoCrud: TipoCrud.alterar,
          pesquisaAlterar: listaPesquisa[index],
        );
      }),
    ).then((value) async {
      await carregarTodosRegistros();
    });
  }

  @override
  void onDeletar(int index) async {
    await util_http.delete(
      path: rotaPesquisa,
      jsonDAO: jsonEncode(listaPesquisa[index].toJson()),
      context: context,
    );
    listaPesquisa.removeAt(index);
    setState(() {});
  }

  @override
  Future<void> carregarTodosRegistros() async {
    listaPesquisa.clear();
    var json = await util_http.get(path: rotaPesquisa, context: context);
    listaPesquisa = List<PesquisaDAO>.from(json.map((json) => PesquisaDAO.fromJson(json)));
    setState(() {});
  }

  @override
  int countListView() {
    return listaPesquisa.length;
  }

  @override
  Widget buildItemListView(context, index) {
    return ListTile(
      leading: Text(listaPesquisa[index].idPesquisa.toString()),
      title: Text(listaPesquisa[index].titulo),
    );
  }
}
