import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:squad_scrum/Consts/consts.dart';
import 'package:squad_scrum/Enumeradores/enumeradores.dart';
import 'package:squad_scrum/ObjetosPostgres/empresa_dao.dart';
import 'package:squad_scrum/util/util_http.dart' as util_http;

class InclusaoEmpresa extends StatefulWidget {
  final TipoCrud tipoCrud;
  final EmpresaDAO? empresaAlterar;

  const InclusaoEmpresa({Key? key, required this.tipoCrud, this.empresaAlterar}) : super(key: key);

  @override
  State<InclusaoEmpresa> createState() => _InclusaoEmpresaState();
}

class _InclusaoEmpresaState extends State<InclusaoEmpresa> {
  TextEditingController controllerCodigo = TextEditingController();
  TextEditingController controllerNome = TextEditingController();


  @override
  void initState() {
    super.initState();
    if (widget.tipoCrud == TipoCrud.alterar) {
      controllerCodigo.text = widget.empresaAlterar!.idEmpresa.toString();
      controllerNome.text = widget.empresaAlterar!.nome;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      floatingActionButton: FloatingActionButton(
        onPressed: salvarEmpresa,
        child: const Icon(Icons.save),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            TextFormField(
              enabled: false,
              controller: controllerCodigo,
              decoration: const InputDecoration(
                labelText: "Código Empresa",
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
                labelText: "Informe o Nome da Empresa",
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void salvarEmpresa() async {
    var equipe = EmpresaDAO(idEmpresa: int.tryParse(controllerCodigo.text), nome: controllerNome.text);
    if (widget.tipoCrud == TipoCrud.inserir) {
      await util_http.post(path: rotaInserirEmpresa, jsonDAO: jsonEncode(equipe.toJson()), context: context);
    } else {
      await util_http.patch(path: rotaAlterarEmpresa, jsonDAO: jsonEncode(equipe.toJson()), context: context);
    }
    Navigator.of(context).pop();
  }
}
