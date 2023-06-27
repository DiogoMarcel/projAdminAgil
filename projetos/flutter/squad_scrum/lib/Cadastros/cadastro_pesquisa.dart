import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:squad_scrum/BaseWidget/base_state_inclusao.dart';
import 'package:squad_scrum/Consts/consts.dart';
import 'package:squad_scrum/EntidadePostgres/pesquisa_dao.dart';
import 'package:squad_scrum/Enumeradores/enumeradores.dart';
import 'package:squad_scrum/util/util_http.dart' as util_http;

class CadastroPesquisa extends StatefulWidget {
  final TipoCrud tipoCrud;
  final PesquisaDAO? pesquisaAlterar;

  const CadastroPesquisa({Key? key, this.tipoCrud = TipoCrud.inserir, this.pesquisaAlterar}): super(key: key);

  @override
  BaseStateInclusao<CadastroPesquisa> createState() => _InclusaoEquipeState();
}

class _InclusaoEquipeState extends BaseStateInclusao<CadastroPesquisa> {
  TextEditingController controllerCodigo = TextEditingController();
  TextEditingController controllerTitulo = TextEditingController();

  @override
  Future<void> onGravar() async {
    var equipe = PesquisaDAO(idPesquisa: int.tryParse(controllerCodigo.text), titulo: controllerTitulo.text);
    if (widget.tipoCrud == TipoCrud.inserir) {
      await util_http.post(path: rotaPesquisa, jsonDAO: jsonEncode(equipe.toJson()), context: context);
    } else {
      await util_http.patch(path: rotaPesquisa, jsonDAO: jsonEncode(equipe.toJson()), context: context);
    }
  }

  @override
  void initState() {
    super.initState();
    super.objetoPostgres = "Pesquisa";
    super.tipoCrud = widget.tipoCrud;
    if (widget.tipoCrud == TipoCrud.alterar) {
      controllerCodigo.text = widget.pesquisaAlterar!.idPesquisa.toString();
      controllerTitulo.text = widget.pesquisaAlterar!.titulo;
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
        validator: onValidarTituloPesquisa,
        autofocus: true,
        controller: controllerTitulo,
        decoration: const InputDecoration(
          labelText: "Informe o Título da Pesquisa",
          border: OutlineInputBorder(),
        ),
      ),
    ];
  }

  String? onValidarTituloPesquisa(value){
    if(value.toString().trim().isEmpty){
      return "Título da Pesquisa Obrigatorio";
    }
    return null;
  }
}
