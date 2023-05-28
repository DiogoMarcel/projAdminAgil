import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:squad_scrum/BaseWidget/base_state_consulta.dart';
import 'package:squad_scrum/Cadastros/inclusao_colaborador.dart';
import 'package:squad_scrum/Cadastros/inclusao_equipe.dart';
import 'package:squad_scrum/Consts/consts.dart';
import 'package:squad_scrum/Enumeradores/enumeradores.dart';
import 'package:squad_scrum/ObjetosPostgres/colaborador_dao.dart';
import 'package:squad_scrum/util/util_http.dart' as util_http;

class ConsultaColaborador extends StatefulWidget {
  const ConsultaColaborador({Key? key}) : super(key: key);

  @override
  BaseStateConsulta<ConsultaColaborador> createState() => _EquipeState();
}

class _EquipeState extends BaseStateConsulta<ConsultaColaborador> {
  List<ColaboradorDAO> listaColaborador = [];

  @override
  void initState() {
    super.tituloTela = "Consulta Colaborador";
    super.initState();
  }

  @override
  void onInserir() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) {
        return const InclusaoColaborador(
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
        return InclusaoColaborador(
          tipoCrud: TipoCrud.alterar,
          colaboradorAlterar: listaColaborador[index],
        );
      }),
    ).then((value) async {
      await carregarTodosRegistros();
    });
  }

  @override
  void onDeletar(int index) async {
    await util_http.delete(
      path: rotaDeletarColaborador,
      jsonDAO: jsonEncode(listaColaborador[index].toJson()),
      context: context,
    );
    listaColaborador.removeAt(index);
    setState(() {});
  }

  @override
  Future<void> carregarTodosRegistros() async {
    listaColaborador.clear();
    var json = await util_http.get(path: pegarTodosColaborador, context: context);
    listaColaborador = List<ColaboradorDAO>.from(json.map((json) => ColaboradorDAO.fromJson(json)));
    setState(() {});
  }

  @override
  int countListView() {
    return listaColaborador.length;
  }

  @override
  Widget buildItemListView(context, index) {
    return ListTile(
      leading: Text(listaColaborador[index].idColaborador.toString()),
      title: Text(listaColaborador[index].usuario),
    );
  }
}
