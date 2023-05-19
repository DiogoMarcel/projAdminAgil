import 'package:flutter/material.dart';
import 'package:squad_scrum/Cadastros/inclusao_equipe.dart';

class ConsultaEquipe extends StatefulWidget {
  const ConsultaEquipe({Key? key}) : super(key: key);

  @override
  State<ConsultaEquipe> createState() => _EquipeState();
}

class _EquipeState extends State<ConsultaEquipe> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Consulta Equipe"),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: rotaInclusao,
        child: Icon(Icons.add),
      ),
      body: Padding(
        padding: EdgeInsets.all(15),
        child: ListView.builder(
          itemCount: 10,
          itemBuilder: (context, index){
            return Card(
              child: ListTile(
                leading: Text('1'),
                title: Text('Luan Chico'),
              ),
            );
          },
        ),
      ),
    );
  }

  void rotaInclusao(){
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context){
        return const InclusaoEquipe();
      }),
    );
  }
}
