import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:squad_scrum/BaseWidget/base_state_consulta.dart';
import 'package:squad_scrum/Cadastros/inclusao_cargo.dart';
import 'package:squad_scrum/Consts/consts.dart';
import 'package:squad_scrum/Enumeradores/enumeradores.dart';
import 'package:squad_scrum/ObjetosPostgres/cargo_dao.dart';
import 'package:squad_scrum/util/util_http.dart' as http_util;

class ConsultaCargo extends StatefulWidget {
  const ConsultaCargo({Key? key}) : super(key: key);

  @override
  BaseStateConsulta<ConsultaCargo> createState() => _ConsultaCargoState();
}

class _ConsultaCargoState extends BaseStateConsulta<ConsultaCargo> {
  List<CargoDAO> listaCargo = [];

  @override
  void initState() {
    super.tituloTela = "Consulta Cargo";
    super.initState();
  }

  @override
  void onInserir() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) {
        return const InclusaoCargo(
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
        return InclusaoCargo(
          tipoCrud: TipoCrud.alterar,
          cargoAlterar: listaCargo[index],
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
    await http_util.delete(
      path: rotaDeletarCargo,
      jsonDAO: jsonEncode(listaCargo[index].toJson()),
      context: context,
    );
    listaCargo.removeAt(index);
    setState(() {});
  }

  @override
  Future<void> carregarTodosRegistros() async {
    listaCargo.clear();
    var json = await http_util.get(path: pegarTodosCargo, context: context);
    listaCargo = List<CargoDAO>.from(json.map((json) => CargoDAO.fromJson(json)));
    setState(() {});
  }

  @override
  int countListView() {
    return listaCargo.length;
  }

  @override
  Widget buildItemListView(context, index) {
    return ListTile(
      leading: Text(listaCargo[index].idCargo.toString()),
      title: Text(listaCargo[index].descricao),
    );
  }
}
