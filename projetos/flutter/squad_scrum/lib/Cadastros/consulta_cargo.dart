import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:squad_scrum/Cadastros/inclusao_cargo.dart';
import 'package:squad_scrum/Consts/consts.dart';
import 'package:squad_scrum/Enumeradores/Enumeradores.dart';
import 'package:squad_scrum/ObjetosPostgres/cargo_dao.dart';
import 'package:http/http.dart' as http;

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
    var url = Uri.http(Ip_Server, Pegar_Todos_Cargo);
    var response = await http.get(url);
    var json = jsonDecode(response.body);

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
        child: const Icon(Icons.add),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
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
        trailing: SizedBox(
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
                  var url = Uri.http(Ip_Server, Rota_Deletar_Cargo);
                  var response = await http.delete(url,
                      body: jsonEncode(listaCargo[index].toJson()));
                  if (response.statusCode == 200) {
                    listaCargo.removeAt(index);
                    setState(() {});
                  }
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