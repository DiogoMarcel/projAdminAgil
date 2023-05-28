import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:squad_scrum/BaseWidget/base_state_inclusao.dart';
import 'package:squad_scrum/Consts/consts.dart';
import 'package:squad_scrum/Enumeradores/enumeradores.dart';
import 'package:squad_scrum/ObjetosPostgres/colaborador_dao.dart';
import 'package:squad_scrum/util/util_http.dart' as util_http;

class InclusaoColaborador extends StatefulWidget {
  const InclusaoColaborador(
      {Key? key, this.tipoCrud = TipoCrud.inserir, this.colaboradorAlterar})
      : super(key: key);

  final TipoCrud tipoCrud;
  final ColaboradorDAO? colaboradorAlterar;

  @override
  BaseStateInclusao<InclusaoColaborador> createState() => _InclusaoCargoState();
}

class _InclusaoCargoState extends BaseStateInclusao<InclusaoColaborador> {
  TextEditingController controllerCodigo = TextEditingController();
  TextEditingController controllerUsuario = TextEditingController();
  TextEditingController controllerSenha = TextEditingController();
  TextEditingController controllerApelido = TextEditingController();
  bool gerenciaPesquisa = false;
  bool gerenciaUsuario = false;

  @override
  void onGravar() async {
    var cargo = ColaboradorDAO(
      idColaborador: int.tryParse(controllerCodigo.text),
      usuario: controllerUsuario.text,
      senha: controllerSenha.text,
      apelido: controllerApelido.text,
      gerenciapesquisa: gerenciaPesquisa,
      gerenciausuario: gerenciaUsuario,
    );
    if (widget.tipoCrud == TipoCrud.inserir) {
      await util_http.post(
          path: rotaInserirColaborador,
          jsonDAO: jsonEncode(cargo.toJson()),
          context: context);
    } else {
      await util_http.patch(
          path: rotaAlterarColaborador,
          jsonDAO: jsonEncode(cargo.toJson()),
          context: context);
    }
    Navigator.of(context).pop();
  }

  @override
  void initState() {
    super.initState();
    if (widget.tipoCrud == TipoCrud.alterar) {
      controllerCodigo.text = widget.colaboradorAlterar!.idColaborador.toString();
      controllerUsuario.text = widget.colaboradorAlterar!.usuario;
      controllerSenha.text = widget.colaboradorAlterar!.senha;
      controllerApelido.text = widget.colaboradorAlterar!.apelido;
      gerenciaPesquisa = widget.colaboradorAlterar!.gerenciapesquisa;
      gerenciaUsuario = widget.colaboradorAlterar!.gerenciausuario;
    }
  }

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
          labelText: "Informe o Nome do Usuário",
          border: OutlineInputBorder(),
        ),
      ),
      const SizedBox(
        height: 15,
      ),
      TextFormField(
        autofocus: true,
        controller: controllerSenha,
        obscureText: true,
        decoration: const InputDecoration(
          labelText: "Informe a Senha",
          border: OutlineInputBorder(),
        ),
      ),
      const SizedBox(
        height: 15,
      ),
      TextFormField(
        autofocus: true,
        controller: controllerApelido,
        decoration: const InputDecoration(
          labelText: "Informe o Apelido",
          border: OutlineInputBorder(),
        ),
      ),
      const SizedBox(
        height: 15,
      ),
      Row(
        children: [
          Text("Gerencia Pesquisa"),
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
          Text("Gerencia Usuário"),
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
