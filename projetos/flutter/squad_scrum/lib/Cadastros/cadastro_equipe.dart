import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:squad_scrum/BaseWidget/base_state_inclusao.dart';
import 'package:squad_scrum/Consts/consts.dart';
import 'package:squad_scrum/Enumeradores/enumeradores.dart';
import 'package:squad_scrum/EntidadePostgres/equipe_dao.dart';
import 'package:squad_scrum/util/util_http.dart' as util_http;

class CadastroEquipe extends StatefulWidget {
  final TipoCrud tipoCrud;
  final EquipeDAO? equipeAlterar;

  const CadastroEquipe({Key? key, this.tipoCrud = TipoCrud.inserir, this.equipeAlterar}): super(key: key);

  @override
  BaseStateInclusao<CadastroEquipe> createState() => _CadastroEquipeState();
}

class _CadastroEquipeState extends BaseStateInclusao<CadastroEquipe> {
  TextEditingController controllerCodigo = TextEditingController();
  TextEditingController controllerNome = TextEditingController();

  @override
  void onGravar() async {
    var equipe = EquipeDAO(idEquipe: int.tryParse(controllerCodigo.text), nome: controllerNome.text);
    if (widget.tipoCrud == TipoCrud.inserir) {
      await util_http.post(path: rotaEquipe, jsonDAO: jsonEncode(equipe.toJson()), context: context);
    } else {
      await util_http.patch(path: rotaEquipe, jsonDAO: jsonEncode(equipe.toJson()), context: context);
    }
    Navigator.of(context).pop();
  }

  @override
  void initState() {
    super.initState();
    super.objetoPostgres = "Equipe";
    super.tipoCrud = widget.tipoCrud;
    if (widget.tipoCrud == TipoCrud.alterar) {
      controllerCodigo.text = widget.equipeAlterar!.idEquipe.toString();
      controllerNome.text = widget.equipeAlterar!.nome;
    }
  }

  @override
  List<Widget> buildListFormField() {
    return [
      TextFormField(
        enabled: false,
        controller: controllerCodigo,
        decoration: const InputDecoration(
          labelText: "Código Equipe",
          border: OutlineInputBorder(),
        ),
      ),
      const SizedBox(
        height: 15,
      ),
      TextFormField(
        autofocus: true,
        controller: controllerNome,
        decoration: const InputDecoration(
          labelText: "Informe o Nome da Equipe",
          border: OutlineInputBorder(),
        ),
      ),
    ];
  }
}
