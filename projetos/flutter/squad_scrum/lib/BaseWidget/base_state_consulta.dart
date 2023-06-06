import 'package:flutter/material.dart';

abstract class BaseStateConsulta<T extends StatefulWidget> extends State<T> {
  late String tituloTela;

  void onInserir() {
    // TODO: implement onInsert
    throw UnimplementedError("Metodo onInsert deve ser implementado no filho!!");
  }

  void onAlterar(BuildContext context, int index) {
    // TODO: implement onAlterar
    throw UnimplementedError("Metodo onAlterar deve ser implementado no filho!!");
  }

  void onDeletar(int index) {
    // TODO: implement onDeletar
    throw UnimplementedError("Metodo onDeletar deve ser implementado no filho!!");
  }

  Future<void> carregarTodosRegistros() async {
    // TODO: implement onDeletar
    throw UnimplementedError("Metodo carregarTodosRegistros deve ser implementado no filho!!");
  }

  int countListView(){
    // TODO: implement onDeletar
    throw UnimplementedError("Metodo carregarTodosRegistros deve ser implementado no filho!!");
  }

  Widget buildItemListView(context, index){
    // TODO: implement buildBaseStateConsulta
    throw UnimplementedError("Implemente o Metodo buildBaseStateConsulta no filho!");
  }

  @override
  void initState() {
    carregarTodosRegistros();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(tituloTela),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: onInserir,
        child: const Icon(Icons.add),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: ListView.builder(
          itemCount: countListView(),
          itemBuilder: (context, index){
            return Card(
              child: ListTile(
                trailing: SizedBox(
                  width: 150,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        onPressed: (){
                          onAlterar(context, index);
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
                        onPressed: (){
                          onDeletar(index);
                        },
                        icon: const Icon(
                          Icons.delete,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                ),
                title: buildItemListView(context, index),
              ),
            );
          },
        ),
      ),
    );
  }
}