import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:squad_scrum/Cadastros/inclusao_cargo.dart';
import 'package:squad_scrum/Consts/consts.dart';
import 'package:squad_scrum/Enumeradores/Enumeradores.dart';
import 'package:squad_scrum/ObjetosPostgres/cargo_dao.dart';
import 'package:squad_scrum/util/util_http.dart' as http_util;

class ConsultaCargo extends StatefulWidget {
  const ConsultaCargo({Key? key}) : super(key: key);

  @override
  State<ConsultaCargo> createState() => _ConsultaCargoState();
}

class _ConsultaCargoState extends State<ConsultaCargo> {
  List<CargoDAO> listaCargo = [];

  @override
  void initState() {
    super.initState();
    carregarTodasCargos();
  }

  Future<void> carregarTodasCargos() async {
    listaCargo.clear();
    var json = await http_util.get(path: Pegar_Todos_Cargo, context: context);

    listaCargo = List<CargoDAO>.from(json.map((json) => CargoDAO.fromJson(json)));
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Consulta Cargo"),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: rotaInclusaoCargo,
        child: Icon(Icons.add),
      ),
      body: Padding(
        padding: EdgeInsets.all(15),
        child: ListView.builder(
          itemCount: listaCargo.length,
          itemBuilder: itemCargo,
        ),
      ),
    );
  }

  Widget itemCargo(context, index) {
    return Card(
      child: ListTile(
        leading: Text(listaCargo[index].idCargo.toString()),
        title: Text(listaCargo[index].descricao),
        trailing: Container(
          width: 150,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) {
                      return InclusaoCargo(
                        tipoCrud: TipoCrud.Alterar,
                        cargoAlterar: listaCargo[index],
                      );
                    }),
                  ).then((value) async {
                    await carregarTodasCargos();
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
                  await http_util.delete(
                    path: Rota_Deletar_Cargo,
                    jsonDAO: jsonEncode(listaCargo[index].toJson()),
                    context: context,
                  );
                  listaCargo.removeAt(index);
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

  void rotaInclusaoCargo() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) {
        return InclusaoCargo(
          tipoCrud: TipoCrud.Inserir,
        );
      }),
    ).then((value) async {
      await carregarTodasCargos();
    });
  }
}
