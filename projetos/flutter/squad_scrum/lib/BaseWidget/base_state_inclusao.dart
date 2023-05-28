import 'package:flutter/material.dart';

abstract class BaseStateInclusao<T extends StatefulWidget> extends State<T> {
  late String tituloTela;

  void onGravar();

  List<Widget> buildListFormField();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
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