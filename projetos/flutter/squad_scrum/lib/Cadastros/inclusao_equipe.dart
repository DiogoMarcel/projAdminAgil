import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:squad_scrum/ObjetosPostgres/equipeDAO.dart';

class InclusaoEquipe extends StatefulWidget {
  const InclusaoEquipe({Key? key}) : super(key: key);

  @override
  State<InclusaoEquipe> createState() => _InclusaoEquipeState();
}

class _InclusaoEquipeState extends State<InclusaoEquipe> {
  TextEditingController controllerNome = TextEditingController();

  @override
  void initState() {
    super.initState();
    controllerNome.text = "Luan Chico";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: salvarEquipe,
        child: Icon(Icons.save),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            TextFormField(
              controller: controllerNome,
              decoration: InputDecoration(
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
    print(jsonEncode(inclusaoEquipe.toJson()));
    var url = Uri.http('localhost:3000', '/equipe/inserirEquipe');
    var response = await http.post(url, body: jsonEncode(inclusaoEquipe.toJson()));
    print(response.body);
  }
}
