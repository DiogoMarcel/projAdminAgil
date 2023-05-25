import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:squad_scrum/Cadastros/inclusao_empresa.dart';
import 'package:squad_scrum/Enumeradores/enumeradores.dart';
import 'package:squad_scrum/ObjetosPostgres/empresa_dao.dart';
import 'package:squad_scrum/Widget/widget_consulta.dart';
import 'package:squad_scrum/Consts/consts.dart';
import 'package:squad_scrum/util/util_http.dart' as util_http;

class ConsultaEmpresa extends StatefulWidget {
  const ConsultaEmpresa({Key? key}) : super(key: key);

  @override
  State<ConsultaEmpresa> createState() => _ConsultaEmpresaState();
}

class _ConsultaEmpresaState extends State<ConsultaEmpresa> {
  List<EmpresaDAO> listaEmpresa = [];

  @override
  void initState() {
    super.initState();
    carregarTodasEmpresas();
  }

  Future<void> carregarTodasEmpresas() async {
    listaEmpresa.clear();
    var json = await util_http.get(path: pegarTodosEmpresa, context: context);

    listaEmpresa = List<EmpresaDAO>.from(json.map((json) => EmpresaDAO.fromJson(json)));
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return WidgetConsulta(
      appBarTitle: "Consulta Empresa",
      onInsert: rotaInclusaoEmpresa,
      body: ListView.builder(
        itemCount: listaEmpresa.length,
        itemBuilder: itemEmpresa,
      ),
    );
  }

  Widget itemEmpresa(context, index) {
    return Card(
      child: ListTile(
        leading: Text(listaEmpresa[index].idEmpresa.toString()),
        title: Text(listaEmpresa[index].nome),
        trailing: SizedBox(
          width: 150,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) {
                      return InclusaoEmpresa(
                        tipoCrud: TipoCrud.alterar,
                        empresaAlterar: listaEmpresa[index],
                      );
                    }),
                  ).then((value) async {
                    await carregarTodasEmpresas();
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
                    path: rotaDeletarEmpresa,
                    jsonDAO: jsonEncode(listaEmpresa[index].toJson()),
                    context: context,
                  );
                  listaEmpresa.removeAt(index);
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

  void rotaInclusaoEmpresa() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) {
        return const InclusaoEmpresa(
          tipoCrud: TipoCrud.inserir,
        );
      }),
    ).then((value) async {
      await carregarTodasEmpresas();
    });
  }
}
