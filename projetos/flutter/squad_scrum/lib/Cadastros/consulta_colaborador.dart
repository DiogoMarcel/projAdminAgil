import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:squad_scrum/Cadastros/cadastro_colaborador.dart';
import 'package:squad_scrum/Consts/consts.dart';
import 'package:squad_scrum/Enumeradores/enumeradores.dart';
import 'package:squad_scrum/EntidadePostgres/colaborador_dao.dart';
import 'package:squad_scrum/Widgets/base_consulta.dart';
import 'package:squad_scrum/util/util_http.dart' as util_http;

class ConsultaColaborador extends StatefulWidget {
  const ConsultaColaborador({Key? key}) : super(key: key);

  @override
  State<ConsultaColaborador> createState() => _ConsultaColaboradorState();
}

class _ConsultaColaboradorState extends State<ConsultaColaborador> {
  List<ColaboradorDAO> listaColaborador = [];
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
          "Usuário",
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

    setState(
      () {
        if (sortColumnIndex == 0) {
          if (sortAscending) {
            listaColaborador.sort((a, b) {
              return b.idColaborador!.compareTo(a.idColaborador!);
            });
          } else {
            listaColaborador.sort((a, b) {
              return a.idColaborador!.compareTo(b.idColaborador!);
            });
          }
        } else if (sortColumnIndex == 1) {
          if (sortAscending) {
            listaColaborador.sort((a, b) {
              return b.usuario.compareTo(a.usuario);
            });
          } else {
            listaColaborador.sort((a, b) {
              return a.usuario.compareTo(b.usuario);
            });
          }
        } else if (sortColumnIndex == 2) {
          if (sortAscending) {
            listaColaborador.sort((a, b) {
              return b.nome.compareTo(a.nome);
            });
          } else {
            listaColaborador.sort((a, b) {
              return a.nome.compareTo(b.nome);
            });
          }
        }
      },
    );
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
      listaDados: listaColaborador,
      processarColunas: (value){
        return [
          DataCell(Text(value.idColaborador.toString())),
          DataCell(Text(value.usuario)),
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
        return const CadastroColaborador(
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
        return CadastroColaborador(
          tipoCrud: TipoCrud.alterar,
          colaboradorAlterar: listaColaborador[index],
        );
      }),
    ).then((value) async {
      await carregarTodosRegistros();
    });
  }

  void onButtonDeletar(int index) async {
    await util_http.delete(
      path: rotaColaborador,
      jsonDAO: jsonEncode(listaColaborador[index].toJson()),
      context: context,
    );
    listaColaborador.removeAt(index);
    setState(() {});
  }

  Future<void> carregarTodosRegistros() async {
    listaColaborador.clear();
    var json = await util_http.get(path: rotaColaborador, context: context);
    listaColaborador = List<ColaboradorDAO>.from(
        json.map((json) => ColaboradorDAO.fromJson(json)));
    setState(() {});
  }
}
