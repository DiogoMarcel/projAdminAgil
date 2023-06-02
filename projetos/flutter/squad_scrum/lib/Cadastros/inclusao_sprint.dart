import 'dart:convert';
import 'package:date_field/date_field.dart';
import 'package:easy_mask/easy_mask.dart';
import 'package:flutter/material.dart';
import 'package:squad_scrum/BaseWidget/base_state_inclusao.dart';
import 'package:squad_scrum/Consts/consts.dart';
import 'package:intl/intl.dart';
import 'package:squad_scrum/EntidadePostgres/sprint_dao.dart';
import 'package:squad_scrum/Enumeradores/enumeradores.dart';
import 'package:squad_scrum/util/util_http.dart' as util_http;

class InclusaoSprint extends StatefulWidget {
  final TipoCrud tipoCrud;
  final SprintDAO? sprintAlterar;

  const InclusaoSprint(
      {Key? key, this.tipoCrud = TipoCrud.inserir, this.sprintAlterar})
      : super(key: key);

  @override
  BaseStateInclusao<InclusaoSprint> createState() => _InclusaoEquipeState();
}

class _InclusaoEquipeState extends BaseStateInclusao<InclusaoSprint> {
  TextEditingController controllerCodigo = TextEditingController();
  TextEditingController controllerNome = TextEditingController();
  late DateTime dataInicio;
  late DateTime dataFinal;

  @override
  void onGravar() async {
    var sprint = SprintDAO(
      idSprint: int.tryParse(controllerCodigo.text),
      dataInicio: dataInicio,
      dataFinal: dataFinal,
      nome: controllerNome.text,
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
    Navigator.of(context).pop();
  }

  @override
  void initState() {
    super.initState();
    super.objetoPostgres = "Sprint";
    super.tipoCrud = widget.tipoCrud;
    if (widget.tipoCrud == TipoCrud.alterar) {
      controllerCodigo.text = widget.sprintAlterar!.idSprint.toString();
      controllerNome.text = widget.sprintAlterar!.nome;
      dataInicio = widget.sprintAlterar!.dataInicio;
      dataFinal = widget.sprintAlterar!.dataFinal;
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
        controller: controllerNome,
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
      DateTimeFormField(
        initialValue: widget.tipoCrud == TipoCrud.alterar ? dataInicio : null,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          labelText: "Informe a Data Inicial",
        ),
        mode: DateTimeFieldPickerMode.date,
        dateFormat: DateFormat("dd-MM-yyyy"),
        onDateSelected: (date){
          dataInicio = date;
        },
      ),
      const SizedBox(
        height: 15,
      ),
      DateTimeFormField(
        initialValue: widget.tipoCrud == TipoCrud.alterar ? dataFinal : null,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          labelText: "Informe a Data Final",
        ),
        mode: DateTimeFieldPickerMode.date,
        dateFormat: DateFormat("dd-MM-yyyy"),
        onDateSelected: (date){
          dataFinal = date;
        },
      ),
      const SizedBox(
        height: 15,
      ),
    ];
  }
}
