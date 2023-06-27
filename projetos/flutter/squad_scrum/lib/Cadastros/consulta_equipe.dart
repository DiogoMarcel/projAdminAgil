import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:squad_scrum/Cadastros/cadastro_equipe.dart';
import 'package:squad_scrum/Consts/consts.dart';
import 'package:squad_scrum/Enumeradores/enumeradores.dart';
import 'package:squad_scrum/EntidadePostgres/equipe_dao.dart';
import 'package:squad_scrum/Widgets/base_consulta.dart';
import 'package:squad_scrum/util/util_http.dart' as util_http;

class ConsultaEquipe extends StatefulWidget {
  const ConsultaEquipe({Key? key}) : super(key: key);

  @override
  State<ConsultaEquipe> createState() => _ConsultaEquipeState();
}

class _ConsultaEquipeState extends State<ConsultaEquipe> {
  List<EquipeDAO> listaEquipe = [];
  bool sortAscending = false;
  int? sortColumnIndex;

  List<DataColumn> listaDataColumn() {
    return [
      DataColumn(
        label: const Text(
          "Id",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        onSort: onSort,
      ),
      DataColumn(
        label: const Text(
          "Nome",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        onSort: onSort,
      ),
    ];
  }

  void onSort(int columnIndex, bool ascending) {
    sortColumnIndex = columnIndex;
    sortAscending = ascending;

    setState(() {
      if (sortColumnIndex == 0) {
        if (sortAscending) {
          listaEquipe.sort((a, b) {
            return b.idEquipe!.compareTo(a.idEquipe!);
          });
        } else {
          listaEquipe.sort((a, b) {
            return a.idEquipe!.compareTo(b.idEquipe!);
          });
        }
      } else if (sortColumnIndex == 1) {
        if (sortAscending) {
          listaEquipe.sort((a, b) {
            return b.nome.compareTo(a.nome);
          });
        } else {
          listaEquipe.sort((a, b) {
            return a.nome.compareTo(b.nome);
          });
        }
      }
    });
  }

  @override
  void initState() {
    super.initState();
    carregarTodosRegistros();
  }

  @override
  Widget build(BuildContext context) {
    return BaseConsulta(
      listaDataColumn: listaDataColumn(),
      listaDados: listaEquipe,
      processarColunas: (value){
        return [
          DataCell(Text(value.idEquipe.toString())),
          DataCell(Text(value.nome)),
        ];
      },
      onButtonInserir: onButtonInserir,
      onAlterar: onButtonAlterar,
      onDeletar: onButtonDeletar,
      sortAscending: sortAscending,
      sortColumnIndex: sortColumnIndex,
    );
  }

  void onButtonInserir() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) {
        return const CadastroEquipe(
          tipoCrud: TipoCrud.inserir,
        );
      }),
    ).then((value) async {
      await carregarTodosRegistros();
    });
  }

  void onButtonAlterar(int index) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) {
        return CadastroEquipe(
          tipoCrud: TipoCrud.alterar,
          equipeAlterar: listaEquipe[index],
        );
      }),
    ).then((value) async {
      await carregarTodosRegistros();
    });
  }

  void onButtonDeletar(int index) async {
    await util_http.delete(
      path: rotaEquipe,
      jsonDAO: jsonEncode(listaEquipe[index].toJson()),
      context: context,
    );
    listaEquipe.removeAt(index);
    setState(() {});
  }

  Future<void> carregarTodosRegistros() async {
    listaEquipe.clear();
    var json = await util_http.get(path: rotaEquipe, context: context);
    listaEquipe = List<EquipeDAO>.from(json.map((json) => EquipeDAO.fromJson(json)));
    setState(() {});
  }
}
