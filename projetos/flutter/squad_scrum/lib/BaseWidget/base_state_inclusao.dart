import 'package:flutter/material.dart';
import 'package:squad_scrum/Enumeradores/enumeradores.dart';

abstract class BaseStateInclusao<T extends StatefulWidget> extends State<T> {
  late String objetoPostgres;
  late TipoCrud tipoCrud;

  void onGravar();

  List<Widget> buildListFormField();

  String get descricaoAppBar{
    var result = tipoCrud == TipoCrud.inserir ? "Inclusão " : "Alteração ";
    return result + objetoPostgres;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(descricaoAppBar),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: onGravar,
        child: const Icon(Icons.save),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: buildListFormField(),
        ),
      ),
    );
  }
}