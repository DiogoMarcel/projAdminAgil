import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:squad_scrum/Consts/consts.dart';
import 'package:squad_scrum/Enumeradores/Enumeradores.dart';
import 'package:squad_scrum/ObjetosPostgres/cargo_dao.dart';
import 'package:http/http.dart' as http;

class InclusaoCargo extends StatefulWidget {
  final TipoCrud tipoCrud;
  final CargoDAO? cargoAlterar;

  InclusaoCargo({Key? key, this.tipoCrud = TipoCrud.Inserir, this.cargoAlterar}) : super(key: key);

  @override
  State<InclusaoCargo> createState() => _InclusaoCargoState();
}

class _InclusaoCargoState extends State<InclusaoCargo> {
  TextEditingController controllerCodigo = TextEditingController();
  TextEditingController controllerDescricao = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.tipoCrud == TipoCrud.Alterar) {
      controllerCodigo.text = widget.cargoAlterar!.idCargo.toString();
      controllerDescricao.text = widget.cargoAlterar!.descricao;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      floatingActionButton: FloatingActionButton(
        onPressed: salvarCargo,
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
                labelText: "Código Cargo",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            TextFormField(
              autofocus: true,
              controller: controllerDescricao,
              decoration: const InputDecoration(
                labelText: "Informe o Nome do Cargo",
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void salvarCargo() async {
    http.Response response;
    var cargo = CargoDAO(idCargo: int.tryParse(controllerCodigo.text), descricao: controllerDescricao.text);
    if (widget.tipoCrud == TipoCrud.Inserir) {
      var url = Uri.http(Ip_Server, Rota_Inserir_Cargo);
      response = await http.post(url, body: jsonEncode(cargo.toJson()));
    } else {
      var url = Uri.http(Ip_Server, Rota_Alterar_Cargo);
      response = await http.patch(url, body: jsonEncode(cargo.toJson())) ;
    }

    if (response.statusCode == 200) {
      Navigator.of(context).pop();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erro ao Gravar o Registro ${response.body}'),
        ),
      );
    }
  }
}
