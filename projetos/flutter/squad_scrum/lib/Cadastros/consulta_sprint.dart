import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:squad_scrum/BaseWidget/base_state_consulta.dart';
import 'package:squad_scrum/Cadastros/inclusao_sprint.dart';
import 'package:squad_scrum/Consts/consts.dart';
import 'package:squad_scrum/EntidadePostgres/sprint_dao.dart';
import 'package:squad_scrum/Enumeradores/enumeradores.dart';
import 'package:squad_scrum/util/util_http.dart' as util_http;

class ConsultaSprint extends StatefulWidget {
  const ConsultaSprint({Key? key}) : super(key: key);

  @override
  BaseStateConsulta<ConsultaSprint> createState() => _EquipeState();
}

class _EquipeState extends BaseStateConsulta<ConsultaSprint> {
  List<SprintDAO> listaSprint = [];

  @override
  void initState() {
    super.tituloTela = "Consulta Sprint";
    super.initState();
  }

  @override
  void onInserir() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) {
        return const InclusaoSprint(
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
        return InclusaoSprint(
          tipoCrud: TipoCrud.alterar,
          sprintAlterar: listaSprint[index],
        );
      }),
    ).then((value) async {
      await carregarTodosRegistros();
    });
  }

  @override
  void onDeletar(int index) async {
    await util_http.delete(
      path: rotaSprint,
      jsonDAO: jsonEncode(listaSprint[index].toJson()),
      context: context,
    );
    listaSprint.removeAt(index);
    setState(() {});
  }

  @override
  Future<void> carregarTodosRegistros() async {
    listaSprint.clear();
    var json = await util_http.get(path: rotaSprint, context: context);
    listaSprint = List<SprintDAO>.from(json.map((json) => SprintDAO.fromJson(json)));
    setState(() {});
  }

  @override
  int countListView() {
    return listaSprint.length;
  }

  @override
  Widget buildItemListView(context, index) {
    return ListTile(
      leading: Text(listaSprint[index].idSprint.toString()),
      title: Text(listaSprint[index].nome),
    );
  }
}
