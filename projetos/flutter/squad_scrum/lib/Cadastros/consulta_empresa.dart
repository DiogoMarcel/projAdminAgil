import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:squad_scrum/BaseWidget/base_state_consulta.dart';
import 'package:squad_scrum/Cadastros/inclusao_empresa.dart';
import 'package:squad_scrum/Enumeradores/enumeradores.dart';
import 'package:squad_scrum/ObjetosPostgres/empresa_dao.dart';
import 'package:squad_scrum/Consts/consts.dart';
import 'package:squad_scrum/util/util_http.dart' as util_http;

class ConsultaEmpresa extends StatefulWidget {
  const ConsultaEmpresa({Key? key}) : super(key: key);

  @override
  BaseStateConsulta<ConsultaEmpresa> createState() => _ConsultaEmpresaState();
}

class _ConsultaEmpresaState extends BaseStateConsulta<ConsultaEmpresa> {
  List<EmpresaDAO> listaEmpresa = [];

  @override
  void initState() {
    super.tituloTela = "Consulta Empresa";
    super.initState();
  }

  @override
  void onInserir() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) {
        return const InclusaoEmpresa(
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
        return InclusaoEmpresa(
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

  @override
  void onDeletar(int index) async {
    await util_http.delete(
      path: rotaDeletarEmpresa,
      jsonDAO: jsonEncode(listaEmpresa[index].toJson()),
      context: context,
    );
    listaEmpresa.removeAt(index);
    setState(() {});
  }

  @override
  Future<void> carregarTodosRegistros() async {
    listaEmpresa.clear();
    var json = await util_http.get(path: pegarTodosEmpresa, context: context);

    listaEmpresa =
        List<EmpresaDAO>.from(json.map((json) => EmpresaDAO.fromJson(json)));
    setState(() {});
  }

  @override
  int countListView() {
    return listaEmpresa.length;
  }

  @override
  Widget buildItemListView(context, index) {
    return ListTile(
      leading: Text(listaEmpresa[index].idEmpresa.toString()),
      title: Text(listaEmpresa[index].nome),
    );
  }
}
