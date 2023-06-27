import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:squad_scrum/Cadastros/cadastro_pesquisa_pergunta.dart';
import 'package:squad_scrum/EntidadePostgres/pesquisa_dao.dart';
import 'package:squad_scrum/EntidadePostgres/pesquisa_pergunta_dao.dart';
import 'package:squad_scrum/Enumeradores/enumeradores.dart';
import 'package:squad_scrum/Widgets/base_consulta.dart';
import 'package:squad_scrum/util/util_http.dart' as util_http;
import '../Consts/consts.dart';

class ConsultaPesquisaPergunta extends StatefulWidget {
  const ConsultaPesquisaPergunta({Key? key}) : super(key: key);

  @override
  State<ConsultaPesquisaPergunta> createState() =>
      _ConsultaPesquisaPerguntaState();
}

class _ConsultaPesquisaPerguntaState extends State<ConsultaPesquisaPergunta> {
  List<PesquisaPerguntaDAO> listaPesquisaPergunta = [];
  List<PesquisaDAO> listaPesquisa = [];
  List<DropdownMenuItem> items = [];
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
          "Pergunta",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        onSort: onSort,
      ),
      DataColumn(
        numeric: true,
        label: const Text(
          "Valor Inicial",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        onSort: onSort,
      ),
      DataColumn(
        numeric: true,
        label: const Text(
          "Valor Final",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        onSort: onSort,
      ),
      DataColumn(
        label: const Text(
          "Tipo Resposta",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        onSort: onSort,
      ),
      DataColumn(
        numeric: true,
        label: const Text(
          "Tamanho Total",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        onSort: onSort,
      ),
      DataColumn(
        label: const Text(
          "Obrigatória",
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
            listaPesquisaPergunta.sort((a, b) {
              return b.idPesquisaPergunta!.compareTo(a.idPesquisaPergunta!);
            });
          } else {
            listaPesquisaPergunta.sort((a, b) {
              return a.idPesquisaPergunta!.compareTo(b.idPesquisaPergunta!);
            });
          }
        } else if (sortColumnIndex == 1) {
          if (sortAscending) {
            listaPesquisaPergunta.sort((a, b) {
              return b.pergunta.compareTo(a.pergunta);
            });
          } else {
            listaPesquisaPergunta.sort((a, b) {
              return a.pergunta.compareTo(b.pergunta);
            });
          }
        } else if (sortColumnIndex == 2) {
          if (sortAscending) {
            listaPesquisaPergunta.sort((a, b) {
              return b.valorInicial.compareTo(a.valorInicial);
            });
          } else {
            listaPesquisaPergunta.sort((a, b) {
              return a.valorInicial.compareTo(b.valorInicial);
            });
          }
        } else if (sortColumnIndex == 3) {
          if (sortAscending) {
            listaPesquisaPergunta.sort((a, b) {
              return b.valorFinal.compareTo(a.valorFinal);
            });
          } else {
            listaPesquisaPergunta.sort((a, b) {
              return a.valorFinal.compareTo(b.valorFinal);
            });
          }
        } else if (sortColumnIndex == 4) {
          if (sortAscending) {
            listaPesquisaPergunta.sort((a, b) {
              return b.tipoResposta.compareTo(a.tipoResposta);
            });
          } else {
            listaPesquisaPergunta.sort((a, b) {
              return a.tipoResposta.compareTo(b.tipoResposta);
            });
          }
        } else if (sortColumnIndex == 5) {
          if (sortAscending) {
            listaPesquisaPergunta.sort((a, b) {
              return b.tamanhoTotal.compareTo(a.tamanhoTotal);
            });
          } else {
            listaPesquisaPergunta.sort((a, b) {
              return a.tamanhoTotal.compareTo(b.tamanhoTotal);
            });
          }
        } else if (sortColumnIndex == 6) {
          if (sortAscending) {
            listaPesquisaPergunta.sort((a, b) {
              return b.obrigatoria
                  .toString()
                  .compareTo(a.obrigatoria.toString());
            });
          } else {
            listaPesquisaPergunta.sort((a, b) {
              return a.obrigatoria
                  .toString()
                  .compareTo(b.obrigatoria.toString());
            });
          }
        }
      },
    );
  }

  @override
  void initState() {
    super.initState();
    carregarItemsPesquisa();
    carregarTodosRegistros();
  }

  @override
  Widget build(BuildContext context) {
    return BaseConsulta(
      listaDataColumn: listaDataColumn(),
      listaDados: listaPesquisaPergunta,
      processarColunas: (value){
        return [
          DataCell(Text(value.idPesquisaPergunta.toString())),
          DataCell(Text(value.pergunta)),
          DataCell(Text(value.valorInicial.toString())),
          DataCell(Text(value.valorFinal.toString())),
          DataCell(Text(value.tipoResposta)),
          DataCell(Text(value.tamanhoTotal.toString())),
          DataCell(Text(value.obrigatoria ? 'Sim' : 'Não')),
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
        return const CadastroPesquisaPergunta(
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
        return CadastroPesquisaPergunta(
          tipoCrud: TipoCrud.alterar,
          pesquisaPerguntaAlterar: listaPesquisaPergunta[index],
        );
      }),
    ).then((value) async {
      await carregarTodosRegistros();
    });
  }

  void onButtonDeletar(int index) async {
    await util_http.delete(
      path: rotaSprint,
      jsonDAO: jsonEncode(listaPesquisaPergunta[index].toJson()),
      context: context,
    );
    listaPesquisaPergunta.removeAt(index);
    setState(() {});
  }

  Future<void> carregarItemsPesquisa() async {
    listaPesquisa.clear();
    var json = await util_http.get(path: rotaPesquisa, context: context);
    listaPesquisa = List<PesquisaDAO>.from(json.map((json) => PesquisaDAO.fromJson(json)));

    for (var element in listaPesquisa) {
      items.add(
        DropdownMenuItem(
          value: element.idPesquisa,
          child: Text(
            "${element.idPesquisa} - ${element.titulo}",
            overflow: TextOverflow.ellipsis,
          ),
        ),
      );
    }
    setState(() {});
  }

  Future<void> carregarTodosRegistros() async {
    listaPesquisaPergunta.clear();
    var json =
        await util_http.get(path: rotaPesquisaPergunta, context: context);
    listaPesquisaPergunta = List<PesquisaPerguntaDAO>.from(
        json.map((json) => PesquisaPerguntaDAO.fromJson(json)));
    setState(() {});
  }
}
