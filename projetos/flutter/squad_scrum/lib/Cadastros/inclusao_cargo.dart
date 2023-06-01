import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:squad_scrum/BaseWidget/base_state_inclusao.dart';
import 'package:squad_scrum/Consts/consts.dart';
import 'package:squad_scrum/Enumeradores/enumeradores.dart';
import 'package:squad_scrum/EntidadePostgres/cargo_dao.dart';
import 'package:squad_scrum/util/util_http.dart' as util_http;

class InclusaoCargo extends StatefulWidget {
  const InclusaoCargo({Key? key, this.tipoCrud = TipoCrud.inserir, this.cargoAlterar}) : super(key: key);

  final TipoCrud tipoCrud;
  final CargoDAO? cargoAlterar;

  @override
  BaseStateInclusao<InclusaoCargo> createState() => _InclusaoCargoState();
}

class _InclusaoCargoState extends BaseStateInclusao<InclusaoCargo> {
  TextEditingController controllerCodigo = TextEditingController();
  TextEditingController controllerDescricao = TextEditingController();

  @override
  void onGravar() async {
    var cargo = CargoDAO(
        idCargo: int.tryParse(controllerCodigo.text),
        descricao: controllerDescricao.text);
    if (widget.tipoCrud == TipoCrud.inserir) {
      await util_http.post(
          path: rotaCargo,
          jsonDAO: jsonEncode(cargo.toJson()),
          context: context);
    } else {
      await util_http.patch(
          path: rotaCargo,
          jsonDAO: jsonEncode(cargo.toJson()),
          context: context);
    }
    Navigator.of(context).pop();
  }

  @override
  void initState() {
    super.initState();
    super.objetoPostgres = "Cargo";
    super.tipoCrud = widget.tipoCrud;
    if (widget.tipoCrud == TipoCrud.alterar) {
      controllerCodigo.text = widget.cargoAlterar!.idCargo.toString();
      controllerDescricao.text = widget.cargoAlterar!.descricao;
    }
  }

  @override
  List<Widget> buildListFormField() {
    return [
      TextFormField(
        enabled: false,
        controller: controllerCodigo,
        decoration: const InputDecoration(
          labelText: "Código Cargo",
          border: OutlineInputBorder(),
        ),
      ),
      const SizedBox(
        height: 15,
      ),
      TextFormField(
        autofocus: true,
        controller: controllerDescricao,
        decoration: const InputDecoration(
          labelText: "Informe o Nome do Cargo",
          border: OutlineInputBorder(),
        ),
      ),
    ];
  }
}
