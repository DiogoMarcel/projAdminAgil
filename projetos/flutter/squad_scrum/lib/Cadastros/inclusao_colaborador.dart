import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:squad_scrum/BaseWidget/base_state_inclusao.dart';
import 'package:squad_scrum/Consts/consts.dart';
import 'package:squad_scrum/Enumeradores/enumeradores.dart';
import 'package:squad_scrum/EntidadePostgres/colaborador_dao.dart';
import 'package:squad_scrum/util/util_http.dart' as util_http;

class InclusaoColaborador extends StatefulWidget {
  const InclusaoColaborador({Key? key, this.tipoCrud = TipoCrud.inserir, this.colaboradorAlterar}) : super(key: key);

  final TipoCrud tipoCrud;
  final ColaboradorDAO? colaboradorAlterar;

  @override
  BaseStateInclusao<InclusaoColaborador> createState() => _InclusaoCargoState();
}

class _InclusaoCargoState extends BaseStateInclusao<InclusaoColaborador> {
  TextEditingController controllerCodigo = TextEditingController();
  TextEditingController controllerUsuario = TextEditingController();
  TextEditingController controllerNome = TextEditingController();
  bool gerenciaPesquisa = false;
  bool gerenciaUsuario = false;

  @override
  void onGravar() async {
    var colaborador = ColaboradorDAO(
      idColaborador: int.tryParse(controllerCodigo.text),
      usuario: controllerUsuario.text,
      nome: controllerNome.text,
      gerenciapesquisa: gerenciaPesquisa,
      gerenciausuario: gerenciaUsuario,
    );
    if (widget.tipoCrud == TipoCrud.inserir) {
      await util_http.post(
          path: rotaColaborador,
          jsonDAO: jsonEncode(colaborador.toJson()),
          context: context);
    } else {
      await util_http.patch(
          path: rotaColaborador,
          jsonDAO: jsonEncode(colaborador.toJson()),
          context: context);
    }
    Navigator.of(context).pop();
  }

  @override
  void initState() {
    super.initState();
    super.objetoPostgres = "Colaborador";
    super.tipoCrud = widget.tipoCrud;
    if (widget.tipoCrud == TipoCrud.alterar) {
      controllerCodigo.text = widget.colaboradorAlterar!.idColaborador.toString();
      controllerUsuario.text = widget.colaboradorAlterar!.usuario;
      controllerNome.text = widget.colaboradorAlterar!.nome;
      gerenciaPesquisa = widget.colaboradorAlterar!.gerenciapesquisa;
      gerenciaUsuario = widget.colaboradorAlterar!.gerenciausuario;
    }
  }

  @override
  List<Widget> buildListFormField() {
    return [
      TextFormField(
        enabled: false,
        controller: controllerCodigo,
        decoration: const InputDecoration(
          labelText: "Código Colaborador",
          border: OutlineInputBorder(),
        ),
      ),
      const SizedBox(
        height: 15,
      ),
      TextFormField(
        autofocus: true,
        controller: controllerUsuario,
        decoration: const InputDecoration(
          labelText: "E-Mail",
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
          labelText: "Nome ou Apelido",
          border: OutlineInputBorder(),
        ),
      ),
      const SizedBox(
        height: 15,
      ),
      Row(
        children: [
          const Text("Gerencia Pesquisa"),
          Switch(
            value: gerenciaPesquisa,
            onChanged: (value) {
              setState(() {
                gerenciaPesquisa = value;
              });
            },
          ),
        ],
      ),
      const SizedBox(
        height: 15,
      ),
      Row(
        children: [
          const Text("Gerencia Usuário"),
          Switch(
            value: gerenciaUsuario,
            onChanged: (value) {
              setState(() {
                gerenciaUsuario = value;
              });
            },
          ),
        ],
      ),
    ];
  }
}
