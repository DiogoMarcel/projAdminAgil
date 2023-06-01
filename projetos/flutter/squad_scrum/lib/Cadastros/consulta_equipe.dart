import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:squad_scrum/BaseWidget/base_state_consulta.dart';
import 'package:squad_scrum/Cadastros/inclusao_equipe.dart';
import 'package:squad_scrum/Consts/consts.dart';
import 'package:squad_scrum/Enumeradores/enumeradores.dart';
import 'package:squad_scrum/EntidadePostgres/equipe_dao.dart';
import 'package:squad_scrum/util/util_http.dart' as util_http;

class ConsultaEquipe extends StatefulWidget {
  const ConsultaEquipe({Key? key}) : super(key: key);

  @override
  BaseStateConsulta<ConsultaEquipe> createState() => _EquipeState();
}

class _EquipeState extends BaseStateConsulta<ConsultaEquipe> {
  List<EquipeDAO> listaEquipe = [];

  @override
  void initState() {
    super.tituloTela = "Consulta Equipe";
    super.initState();
  }

  @override
  void onInserir() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) {
        return const InclusaoEquipe(
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
        return InclusaoEquipe(
          tipoCrud: TipoCrud.alterar,
          equipeAlterar: listaEquipe[index],
        );
      }),
    ).then((value) async {
      await carregarTodosRegistros();
    });
  }

  @override
  void onDeletar(int index) async {
    await util_http.delete(
      path: rotaEquipe,
      jsonDAO: jsonEncode(listaEquipe[index].toJson()),
      context: context,
    );
    listaEquipe.removeAt(index);
    setState(() {});
  }

  @override
  Future<void> carregarTodosRegistros() async {
    listaEquipe.clear();
    var json = await util_http.get(path: rotaEquipe, context: context);
    listaEquipe =
        List<EquipeDAO>.from(json.map((json) => EquipeDAO.fromJson(json)));
    setState(() {});
  }

  @override
  int countListView() {
    return listaEquipe.length;
  }

  @override
  Widget buildItemListView(context, index) {
    return ListTile(
      leading: Text(listaEquipe[index].idEquipe.toString()),
      title: Text(listaEquipe[index].nome),
    );
  }
}
