import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:squad_scrum/BaseWidget/base_state_inclusao.dart';
import 'package:squad_scrum/Consts/consts.dart';
import 'package:squad_scrum/Enumeradores/enumeradores.dart';
import 'package:squad_scrum/ObjetosPostgres/funcao_dao.dart';
import 'package:squad_scrum/util/util_http.dart' as util_http;

class InclusaoFuncao extends StatefulWidget {
  final TipoCrud tipoCrud;
  final FuncaoDAO? funcaoAlterar;

  const InclusaoFuncao({Key? key, this.tipoCrud = TipoCrud.inserir, this.funcaoAlterar}): super(key: key);

  @override
  BaseStateInclusao<InclusaoFuncao> createState() => _InclusaoEquipeState();
}

class _InclusaoEquipeState extends BaseStateInclusao<InclusaoFuncao> {
  TextEditingController controllerCodigo = TextEditingController();
  TextEditingController controllerDescricao = TextEditingController();

  @override
  void onGravar() async {
    var equipe = FuncaoDAO(idFuncao: int.tryParse(controllerCodigo.text), descricao: controllerDescricao.text);
    if (widget.tipoCrud == TipoCrud.inserir) {
      await util_http.post(path: rotaInserirFuncao, jsonDAO: jsonEncode(equipe.toJson()), context: context);
    } else {
      await util_http.patch(path: rotaAlterarFuncao, jsonDAO: jsonEncode(equipe.toJson()), context: context);
    }
    Navigator.of(context).pop();
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
          labelText: "Código Funcao",
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
          labelText: "Informe o Nome da Função",
          border: OutlineInputBorder(),
        ),
      ),
    ];
  }
}
