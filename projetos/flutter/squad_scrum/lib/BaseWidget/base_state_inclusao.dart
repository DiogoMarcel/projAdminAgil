import 'dart:io';

import 'package:flutter/material.dart';
import 'package:squad_scrum/Enumeradores/enumeradores.dart';

abstract class BaseStateInclusao<T extends StatefulWidget> extends State<T> {
  final formKey = GlobalKey<FormState>();
  late String objetoPostgres;
  late TipoCrud tipoCrud;

  List<Widget> buildListFormField();
  Future<void> onGravar();

  void _onValidarForm() {
    if(formKey.currentState!.validate()){
      onGravar().then((value){
        Navigator.of(context).pop();
      });
    }
  }

  String get descricaoAppBar{
    var result = tipoCrud == TipoCrud.inserir ? "Inclusão " : "Alteração ";
    return result + objetoPostgres;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(descricaoAppBar),
          centerTitle: true,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _onValidarForm,
          child: const Icon(Icons.save),
        ),
        body: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: buildListFormField(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}