import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:squad_scrum/Cadastros/inclusao_cargo.dart';
import 'package:squad_scrum/Consts/consts.dart';
import 'package:squad_scrum/Enumeradores/enumeradores.dart';
import 'package:squad_scrum/ObjetosPostgres/cargo_dao.dart';
import 'package:squad_scrum/Widget/widget_consulta.dart';
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
    var json = await http_util.get(path: pegarTodosCargo, context: context);

    listaCargo = List<CargoDAO>.from(json.map((json) => CargoDAO.fromJson(json)));
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return WidgetConsulta(
      appBarTitle: "Consulta Cargo",
      onInsert: rotaInclusaoCargo,
      body: ListView.builder(
        itemCount: listaCargo.length,
        itemBuilder: itemCargo,
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
                        tipoCrud: TipoCrud.alterar,
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
                    path: rotaDeletarCargo,
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
        return const InclusaoCargo(
          tipoCrud: TipoCrud.inserir,
        );
      }),
    ).then((value) async {
      await carregarTodasCargos();
    });
  }
}
