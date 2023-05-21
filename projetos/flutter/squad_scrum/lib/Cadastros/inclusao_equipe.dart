import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:squad_scrum/Consts/consts.dart';
import 'package:squad_scrum/Enumeradores/Enumeradores.dart';
import 'package:squad_scrum/ObjetosPostgres/equipe_dao.dart';
import 'package:squad_scrum/util/util_http.dart' as util_http;

class InclusaoEquipe extends StatefulWidget {
  final TipoCrud tipoCrud;
  final EquipeDAO? equipeAlterar;

  const InclusaoEquipe({Key? key, this.tipoCrud = TipoCrud.Inserir, this.equipeAlterar}): super(key: key);

  @override
  State<InclusaoEquipe> createState() => _InclusaoEquipeState();
}

class _InclusaoEquipeState extends State<InclusaoEquipe> {
  TextEditingController controllerCodigo = TextEditingController();
  TextEditingController controllerNome = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.tipoCrud == TipoCrud.Alterar) {
      controllerCodigo.text = widget.equipeAlterar!.idEquipe.toString();
      controllerNome.text = widget.equipeAlterar!.nome;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      floatingActionButton: FloatingActionButton(
        onPressed: salvarEquipe,
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
          ],
        ),
      ),
    );
  }

  void salvarEquipe() async {
    var equipe = EquipeDAO(idEquipe: int.tryParse(controllerCodigo.text), nome: controllerNome.text);
    if (widget.tipoCrud == TipoCrud.Inserir) {
      await util_http.post(path: Rota_Inserir_Equipe, jsonDAO: jsonEncode(equipe.toJson()), context: context);
    } else {
      await util_http.patch(path: Rota_Alterar_Equipe, jsonDAO: jsonEncode(equipe.toJson()), context: context);
    }
    Navigator.of(context).pop();
  }
}
