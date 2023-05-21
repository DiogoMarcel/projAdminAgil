import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:squad_scrum/Cadastros/inclusao_equipe.dart';
import 'package:squad_scrum/Consts/consts.dart';
import 'package:squad_scrum/Enumeradores/Enumeradores.dart';
import 'package:squad_scrum/ObjetosPostgres/equipe_dao.dart';
import 'package:squad_scrum/util/util_http.dart' as util_http;

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
    var json = await util_http.get(path: Pegar_Todas_Equipes, context: context);

    listaEquipe = List<EquipeDAO>.from(json.map((json) {
      return EquipeDAO.fromJson(json);
    }));
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
        trailing: Container(
          width: 150,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) {
                      return InclusaoEquipe(
                        tipoCrud: TipoCrud.Alterar,
                        equipeAlterar: listaEquipe[index],
                      );
                    }),
                  ).then((value) async {
                    await carregarTodasEquipes();
                  });
                },
                icon: const Icon(
                  Icons.edit,
                  color: Colors.black,
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              IconButton(
                onPressed: () async {
                  await util_http.delete(
                      path: Rota_Deletar_Equipe,
                      jsonDAO: jsonEncode(listaEquipe[index].toJson()),
                      context: context);
                  listaEquipe.removeAt(index);
                  setState(() {});
                },
                icon: const Icon(
                  Icons.delete,
                  color: Colors.red,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void rotaInclusaoEquipe() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) {
        return InclusaoEquipe(
          tipoCrud: TipoCrud.Inserir,
        );
      }),
    ).then((value) async {
      await carregarTodasEquipes();
    });
  }
}
