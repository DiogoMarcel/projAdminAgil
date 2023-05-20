import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:squad_scrum/Consts/consts.dart';
import 'package:squad_scrum/ObjetosPostgres/equipeDAO.dart';

class InclusaoEquipe extends StatefulWidget {
  const InclusaoEquipe({Key? key}) : super(key: key);

  @override
  State<InclusaoEquipe> createState() => _InclusaoEquipeState();
}

class _InclusaoEquipeState extends State<InclusaoEquipe> {
  TextEditingController controllerNome = TextEditingController();

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
              autofocus: true,
              controller: controllerNome,
              decoration: const InputDecoration(
                labelText: "Informe o nome da equipe",
                border: OutlineInputBorder(),
              ),
            )
          ],
        ),
      ),
    );
  }

  void salvarEquipe() async {
    var inclusaoEquipe = EquipeDAO(nome: controllerNome.text);
    var url = Uri.http(Ip_Server, Rota_Inserir_Equipe);
    var response = await http.post(url, body: jsonEncode(inclusaoEquipe.toJson()));

    if (response.statusCode == 200) {
      Navigator.of(context).pop();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erro ao inserir Registro' + response.body),
        ),
      );
    }
  }
}
