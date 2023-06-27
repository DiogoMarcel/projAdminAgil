import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:squad_scrum/BaseWidget/base_state_inclusao.dart';
import 'package:squad_scrum/Consts/consts.dart';
import 'package:squad_scrum/Enumeradores/enumeradores.dart';
import 'package:squad_scrum/EntidadePostgres/funcao_dao.dart';
import 'package:squad_scrum/util/util_http.dart' as util_http;

class CadastroFuncao extends StatefulWidget {
  final TipoCrud tipoCrud;
  final FuncaoDAO? funcaoAlterar;

  const CadastroFuncao({Key? key, this.tipoCrud = TipoCrud.inserir, this.funcaoAlterar}): super(key: key);

  @override
  BaseStateInclusao<CadastroFuncao> createState() => _InclusaoEquipeState();
}

class _InclusaoEquipeState extends BaseStateInclusao<CadastroFuncao> {
  TextEditingController controllerCodigo = TextEditingController();
  TextEditingController controllerDescricao = TextEditingController();

  @override
  Future<void> onGravar() async {
    var equipe = FuncaoDAO(idFuncao: int.tryParse(controllerCodigo.text), descricao: controllerDescricao.text);
    if (widget.tipoCrud == TipoCrud.inserir) {
      await util_http.post(path: rotaFuncao, jsonDAO: jsonEncode(equipe.toJson()), context: context);
    } else {
      await util_http.patch(path: rotaFuncao, jsonDAO: jsonEncode(equipe.toJson()), context: context);
    }
  }

  @override
  void initState() {
    super.initState();
    super.objetoPostgres = "Função";
    super.tipoCrud = widget.tipoCrud;
    if (widget.tipoCrud == TipoCrud.alterar) {
      controllerCodigo.text = widget.funcaoAlterar!.idFuncao.toString();
      controllerDescricao.text = widget.funcaoAlterar!.descricao;
    }
  }

  @override
  List<Widget> buildListFormField() {
    return [
      TextFormField(
        enabled: false,
        controller: controllerCodigo,
        decoration: const InputDecoration(
          labelText: "Código",
          border: OutlineInputBorder(),
        ),
      ),
      const SizedBox(
        height: 15,
      ),
      TextFormField(
        validator: onValidarNomeFuncao,
        autofocus: true,
        controller: controllerDescricao,
        decoration: const InputDecoration(
          labelText: "Informe o Nome da Função",
          border: OutlineInputBorder(),
        ),
      ),
    ];
  }

  String? onValidarNomeFuncao(value) {
    if (value.toString().trim().isEmpty) {
      return "Nome da Função Inválida";
    }
    return null;
  }
}
