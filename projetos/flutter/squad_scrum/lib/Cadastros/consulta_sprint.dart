import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:squad_scrum/Cadastros/cadastro_sprint.dart';
import 'package:squad_scrum/Consts/consts.dart';
import 'package:squad_scrum/EntidadePostgres/pesquisa_dao.dart';
import 'package:squad_scrum/EntidadePostgres/sprint_dao.dart';
import 'package:squad_scrum/EntidadePostgres/sprint_pesquisa_dao.dart';
import 'package:squad_scrum/Enumeradores/enumeradores.dart';
import 'package:intl/intl.dart';
import 'package:squad_scrum/Widgets/base_consulta.dart';
import 'package:squad_scrum/util/util_http.dart' as util_http;

class ConsultaSprint extends StatefulWidget {
  const ConsultaSprint({Key? key}) : super(key: key);

  @override
  State<ConsultaSprint> createState() => _ConsultaSprintState();
}

class _ConsultaSprintState extends State<ConsultaSprint> {
  List<SprintDAO> listaSprint = [];
  bool sortAscending = false;
  int? sortColumnIndex;

  List<DataColumn> listaDataColumn() {
    return [
      DataColumn(
        numeric: true,
        label: const Text(
          "Código",
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
      DataColumn(
        label: const Text(
          "Data Inicial",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        onSort: onSort,
      ),
      DataColumn(
        label: const Text(
          "Data Final",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        onSort: onSort,
      ),
      const DataColumn(
        label: Text(
          "Pesquisa",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    ];
  }

  void onSort(int columnIndex, bool ascending) {
    sortColumnIndex = columnIndex;
    sortAscending = ascending;

    setState(() {
      if (sortColumnIndex == 0) {
        if (sortAscending) {
          listaSprint.sort((a, b) {
            return b.idSprint!.compareTo(a.idSprint!);
          });
        } else {
          listaSprint.sort((a, b) {
            return a.idSprint!.compareTo(b.idSprint!);
          });
        }
      } else if (sortColumnIndex == 1) {
        if (sortAscending) {
          listaSprint.sort((a, b) {
            return b.nome.compareTo(a.nome);
          });
        } else {
          listaSprint.sort((a, b) {
            return a.nome.compareTo(b.nome);
          });
        }
      } else if (sortColumnIndex == 2) {
        if (sortAscending) {
          listaSprint.sort((a, b) {
            return b.dataInicio.compareTo(a.dataInicio);
          });
        } else {
          listaSprint.sort((a, b) {
            return a.dataInicio.compareTo(b.dataInicio);
          });
        }
      } else if (sortColumnIndex == 3) {
        if (sortAscending) {
          listaSprint.sort((a, b) {
            return b.dataFinal.compareTo(a.dataFinal);
          });
        } else {
          listaSprint.sort((a, b) {
            return a.dataFinal.compareTo(b.dataFinal);
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
      listaDados: listaSprint,
      processarColunas: (value){
        return [
          DataCell(Text(value.idSprint.toString())),
          DataCell(Text(value.nome)),
          DataCell(Text(DateFormat("dd-MM-yyyy").format(value.dataInicio))),
          DataCell(Text(DateFormat("dd-MM-yyyy").format(value.dataFinal))),
          DataCell(Text(getDescricaoColunaPesquisa(value))),
        ];
      },
      onButtonInserir: onButtonInserir,
      onAlterar: onButtonAlterar,
      onDeletar: onButtonDeletar,
      sortAscending: sortAscending,
      sortColumnIndex: sortColumnIndex,
    );
  }
  
  String getDescricaoColunaPesquisa(value){
    if(value.pesquisaDAO.idPesquisa == null){
      return "";
    }
    return "${value.pesquisaDAO.idPesquisa} - ${value.pesquisaDAO.titulo}";
  }

  void onButtonInserir() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) {
        return const CadastroSprint(
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
        return CadastroSprint(
          tipoCrud: TipoCrud.alterar,
          sprintAlterar: listaSprint[index],
        );
      }),
    ).then((value) async {
      await carregarTodosRegistros();
    });
  }

  void onButtonDeletar(int index) async {
    await util_http.delete(
      path: rotaSprint,
      jsonDAO: jsonEncode(listaSprint[index].toJson()),
      context: context,
    );
    listaSprint.removeAt(index);
    setState(() {});
  }

  Future<void> carregarTodosRegistros() async {
    listaSprint.clear();
    var json = await util_http.get(path: rotaSprint, context: context);
    listaSprint = List<SprintDAO>.from(json.map((json) => SprintDAO.fromJson(json)));
    setState(() {});
  }
}
