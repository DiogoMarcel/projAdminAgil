import 'dart:convert';
import 'package:easy_mask/easy_mask.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:search_choices/search_choices.dart';
import 'package:squad_scrum/BaseWidget/base_state_inclusao.dart';
import 'package:squad_scrum/Consts/consts.dart';
import 'package:squad_scrum/EntidadePostgres/pesquisa_dao.dart';
import 'package:squad_scrum/EntidadePostgres/sprint_dao.dart';
import 'package:squad_scrum/Enumeradores/enumeradores.dart';
import 'package:squad_scrum/Widgets/date_time_textfield.dart';
import 'package:squad_scrum/util/util_http.dart' as util_http;

class CadastroSprint extends StatefulWidget {
  final TipoCrud tipoCrud;
  final SprintDAO? sprintAlterar;

  const CadastroSprint(
      {Key? key, this.tipoCrud = TipoCrud.inserir, this.sprintAlterar})
      : super(key: key);

  @override
  BaseStateInclusao<CadastroSprint> createState() => _InclusaoEquipeState();
}

class _InclusaoEquipeState extends BaseStateInclusao<CadastroSprint> {
  List<PesquisaDAO> listaPesquisa = [];
  List<DropdownMenuItem> items = [];
  TextEditingController controllerCodigo = TextEditingController();
  TextEditingController controllerVersaoSprint = TextEditingController();
  TextEditingController controllerDataInicial = TextEditingController();
  TextEditingController controllerDataFinal = TextEditingController();
  TextEditingController controllerPesquisa = TextEditingController();

  Future<void> carregarItemsPesquisa() async {
    listaPesquisa.clear();
    var json = await util_http.get(path: rotaPesquisa, context: context);
    listaPesquisa = List<PesquisaDAO>.from(json.map((json) => PesquisaDAO.fromJson(json)));

    for (var element in listaPesquisa) {
      items.add(
        DropdownMenuItem(
          value: element.idPesquisa,
          child: Text(
            "${element.idPesquisa} - ${element.titulo}",
            overflow: TextOverflow.ellipsis,
          ),
        ),
      );
    }
    setState(() {});
  }

  @override
  Future<void> onGravar() async {
    var sprint = SprintDAO(
      idSprint: int.tryParse(controllerCodigo.text),
      dataInicio: DateFormat("dd-MM-yyyy").parse(controllerDataInicial.text),
      dataFinal: DateFormat("dd-MM-yyyy").parse(controllerDataFinal.text),
      nome: controllerVersaoSprint.text,
      pesquisaDAO: PesquisaDAO(
        idPesquisa: int.parse(controllerPesquisa.text),
        titulo: "",
      ),
    );
    if (widget.tipoCrud == TipoCrud.inserir) {
      await util_http.post(
          path: rotaSprint,
          jsonDAO: jsonEncode(sprint.toJson()),
          context: context);
    } else {
      await util_http.patch(
          path: rotaSprint,
          jsonDAO: jsonEncode(sprint.toJson()),
          context: context);
    }
  }

  @override
  void initState() {
    super.initState();
    super.objetoPostgres = "Sprint";
    super.tipoCrud = widget.tipoCrud;
    carregarItemsPesquisa();
    if (widget.tipoCrud == TipoCrud.alterar) {
      controllerCodigo.text = widget.sprintAlterar!.idSprint.toString();
      controllerVersaoSprint.text = widget.sprintAlterar!.nome;
      controllerDataInicial.text = DateFormat("dd-MM-yyyy").format(widget.sprintAlterar!.dataInicio);
      controllerDataFinal.text = DateFormat("dd-MM-yyyy").format(widget.sprintAlterar!.dataFinal);
      controllerPesquisa.text = widget.sprintAlterar!.pesquisaDAO!.idPesquisa.toString();
    }
  }

  @override
  List<Widget> buildListFormField() {
    return [
      TextFormField(
        enabled: false,
        controller: controllerCodigo,
        decoration: const InputDecoration(
          labelText: "Código Sprint",
          border: OutlineInputBorder(),
        ),
      ),
      const SizedBox(
        height: 15,
      ),
      TextFormField(
        autofocus: true,
        controller: controllerVersaoSprint,
        validator: onValidarVersaoSprint,
        decoration: const InputDecoration(
          labelText: "Informe a versão da Sprint",
          border: OutlineInputBorder(),
        ),
        inputFormatters: [
          TextInputMask(
            mask: "99.9.9.9",
          ),
        ],
      ),
      const SizedBox(
        height: 15,
      ),
      DateTimeTextField(
        controller: controllerDataInicial,
        hintText: "Data Inicial",
      ),
      const SizedBox(
        height: 15,
      ),
      DateTimeTextField(
        controller: controllerDataFinal,
        hintText: "Data Final",
      ),
      const SizedBox(
        height: 15,
      ),
      Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(3),
          border: Border.all(
            color: Colors.grey,
          ),
        ),
        child: SearchChoices.single(
          validator: onValidarPesquisa,
          padding: const EdgeInsets.only(left: 10),
          underline: Container(
            height: 0,
          ),
          hint: "Pesquisa",
          isExpanded: true,
          items: items,
          value: tipoCrud == TipoCrud.inserir ? null : int.parse(controllerPesquisa.text),
          onChanged: (value) {
            controllerPesquisa.text = value.toString();
          },
        ),
      ),
    ];
  }

  String? onValidarVersaoSprint(value){
    if(value.toString().isEmpty){
      return "Versão da Sprint Obrigatório";
    }
    return null;
  }

  String? onValidarPesquisa(value) {
    if (value == null) {
      return "Pesquisa Obrigatória";
    }
    return null;
  }
}
