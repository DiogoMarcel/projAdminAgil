import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:squad_scrum/BaseWidget/base_state_consulta.dart';
import 'package:squad_scrum/Cadastros/inclusao_funcao.dart';
import 'package:squad_scrum/Consts/consts.dart';
import 'package:squad_scrum/Enumeradores/enumeradores.dart';
import 'package:squad_scrum/ObjetosPostgres/funcao_dao.dart';
import 'package:squad_scrum/util/util_http.dart' as util_http;

class ConsultaFuncao extends StatefulWidget {
  const ConsultaFuncao({Key? key}) : super(key: key);

  @override
  BaseStateConsulta<ConsultaFuncao> createState() => _EquipeState();
}

class _EquipeState extends BaseStateConsulta<ConsultaFuncao> {
  List<FuncaoDAO> listaFuncao = [];

  @override
  void initState() {
    super.tituloTela = "Consulta Funcao";
    super.initState();
  }

  @override
  void onInserir() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) {
        return const InclusaoFuncao(
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
        return InclusaoFuncao(
          tipoCrud: TipoCrud.alterar,
          funcaoAlterar: listaFuncao[index],
        );
      }),
    ).then((value) async {
      await carregarTodosRegistros();
    });
  }

  @override
  void onDeletar(int index) async {
    await util_http.delete(
      path: rotaDeletarFuncao,
      jsonDAO: jsonEncode(listaFuncao[index].toJson()),
      context: context,
    );
    listaFuncao.removeAt(index);
    setState(() {});
  }

  @override
  Future<void> carregarTodosRegistros() async {
    listaFuncao.clear();
    var json = await util_http.get(path: pegarTodosFuncao, context: context);
    listaFuncao = List<FuncaoDAO>.from(json.map((json) => FuncaoDAO.fromJson(json)));
    setState(() {});
  }

  @override
  int countListView() {
    return listaFuncao.length;
  }

  @override
  Widget buildItemListView(context, index) {
    return ListTile(
      leading: Text(listaFuncao[index].idFuncao.toString()),
      title: Text(listaFuncao[index].descricao),
    );
  }
}
