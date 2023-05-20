import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:squad_scrum/Cadastros/inclusao_equipe.dart';
import 'package:squad_scrum/Consts/consts.dart';
import 'package:squad_scrum/ObjetosPostgres/equipeDAO.dart';
import 'package:http/http.dart' as http;

class ConsultaEquipe extends StatefulWidget {
  const ConsultaEquipe({Key? key}) : super(key: key);

  @override
  State<ConsultaEquipe> createState() => _EquipeState();
}

class _EquipeState extends State<ConsultaEquipe> {
  List<EquipeDAO> listaEquipe = [];

  @override
  void initState() {
    super.initState();
    carregarTodasEquipes();
  }

  Future<void> carregarTodasEquipes() async {
    listaEquipe.clear();
    var url = Uri.http(Ip_Server, Pegar_Todas_Equipes);
    var response = await http.get(url);
    var json = jsonDecode(response.body);

    listaEquipe =
        List<EquipeDAO>.from(json.map((json) => EquipeDAO.fromJson(json)));
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Consulta Equipe"),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: rotaInclusaoEquipe,
        child: Icon(Icons.add),
      ),
      body: Padding(
        padding: EdgeInsets.all(15),
        child: ListView.builder(
          itemCount: listaEquipe.length,
          itemBuilder: itemEquipe,
        ),
      ),
    );
  }

  Widget itemEquipe(context, index) {
    return Card(
      child: ListTile(
        leading: Text(listaEquipe[index].idEquipe.toString()),
        title: Text(listaEquipe[index].nome),
        trailing: IconButton(
          onPressed: () async {
            var url = Uri.http(Ip_Server, Rota_Deletar_Equipe);
            var response = await http.delete(url,
                body: jsonEncode(listaEquipe[index].toJson()));
            if (response.statusCode == 200) {
              listaEquipe.removeAt(index);
              setState(() {});
            }
          },
          icon: const Icon(
            Icons.delete,
            color: Colors.red,
          ),
        ),
      ),
    );
  }

  void rotaInclusaoEquipe() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) {
        return const InclusaoEquipe();
      }),
    ).then((value) async {
      await carregarTodasEquipes();
    });
  }

  void excluirEquipe() {}
}
