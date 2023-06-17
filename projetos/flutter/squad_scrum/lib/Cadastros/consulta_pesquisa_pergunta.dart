import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:search_choices/search_choices.dart';
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
      const DataColumn(
        label: Text(""),
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

  List<DataRow> listaDataRow() {
    return listaPesquisaPergunta
        .map(
          (e) => DataRow(
              color: MaterialStateProperty.resolveWith<Color?>(
                (Set<MaterialState> states) {
                  if (states.contains(MaterialState.selected)) {
                    return Theme.of(context)
                        .colorScheme
                        .primary
                        .withOpacity(0.08);
                  }
                  if (listaPesquisaPergunta.indexOf(e).isEven) {
                    return Colors.grey.withOpacity(0.3);
                  }
                  return null;
                },
              ),
              cells: [
                DataCell(Text(e.idPesquisaPergunta.toString())),
                DataCell(Text(e.pergunta)),
                DataCell(Text(e.valorInicial.toString())),
                DataCell(Text(e.valorFinal.toString())),
                DataCell(Text(e.tipoResposta)),
                DataCell(Text(e.tamanhoTotal.toString())),
                DataCell(Text(e.obrigatoria ? 'Sim' : 'Não')),
                DataCell(
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          onButtonAlterar(
                              context, listaPesquisaPergunta.indexOf(e));
                        },
                        icon: const Icon(
                          Icons.edit,
                        ),
                      ),
                      const SizedBox(
                        width: 30,
                      ),
                      IconButton(
                        onPressed: () {
                          onButtonDeletar(listaPesquisaPergunta.indexOf(e));
                        },
                        icon: const Icon(
                          Icons.delete,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                ),
              ]),
        )
        .toList();
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
      sortColumnIndex: sortColumnIndex,
      sortAscending: sortAscending,
      listaDataColumn: listaDataColumn(),
      listaDataRow: listaDataRow(),
      onButtonInserir: onButtonInserir,
      tituloTela: "Consulta Pesquisa Pergunta",
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

  void onButtonAlterar(BuildContext context, int index) {
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
