import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:search_choices/search_choices.dart';
import 'package:squad_scrum/BaseWidget/base_state_inclusao.dart';
import 'package:squad_scrum/Consts/consts.dart';
import 'package:squad_scrum/EntidadePostgres/pesquisa_dao.dart';
import 'package:squad_scrum/EntidadePostgres/pesquisa_pergunta_dao.dart';
import 'package:squad_scrum/Enumeradores/enumeradores.dart';
import 'package:squad_scrum/util/util_http.dart' as util_http;

class CadastroPesquisaPergunta extends StatefulWidget {
  final TipoCrud tipoCrud;
  final PesquisaPerguntaDAO? pesquisaPerguntaAlterar;

  const CadastroPesquisaPergunta(
      {Key? key,
      this.tipoCrud = TipoCrud.inserir,
      this.pesquisaPerguntaAlterar})
      : super(key: key);

  @override
  BaseStateInclusao<CadastroPesquisaPergunta> createState() =>
      _CadastroPesquisaPerguntaState();
}

class _CadastroPesquisaPerguntaState
    extends BaseStateInclusao<CadastroPesquisaPergunta> {
  TextEditingController controllerCodigo = TextEditingController();
  TextEditingController controllerPergunta = TextEditingController();
  TextEditingController controllerValorInicial = TextEditingController();
  TextEditingController controllerValorFinal = TextEditingController();
  TextEditingController controllerTamanhoTotal = TextEditingController();

  String? valueTipoResposta;
  bool? valueObrigatorio;
  List<int>? valuePesquisa;
  List<PesquisaDAO> listaPesquisa = [];
  List<DropdownMenuItem> items = [];

  @override
  void initState() {
    super.initState();
    super.objetoPostgres = "Pesquisa Pergunta";
    super.tipoCrud = widget.tipoCrud;
    if (widget.tipoCrud == TipoCrud.alterar) {
      controllerCodigo.text = widget.pesquisaPerguntaAlterar!.idPesquisaPergunta.toString();
      controllerPergunta.text = widget.pesquisaPerguntaAlterar!.pergunta;
      controllerValorInicial.text = widget.pesquisaPerguntaAlterar!.valorInicial.toString();
      controllerValorFinal.text = widget.pesquisaPerguntaAlterar!.valorFinal.toString();
      controllerTamanhoTotal.text = widget.pesquisaPerguntaAlterar!.tamanhoTotal.toString();
      valueTipoResposta = widget.pesquisaPerguntaAlterar!.tipoResposta;
      valueObrigatorio = widget.pesquisaPerguntaAlterar!.obrigatoria;
    }
    carregarItemsPesquisa();
  }

  @override
  List<Widget> buildListFormField() {
    return [
      TextFormField(
        enabled: false,
        controller: controllerCodigo,
        decoration: const InputDecoration(
          labelText: "Código",
          border: OutlineInputBorder(),
        ),
      ),
      const SizedBox(
        height: 15,
      ),
      TextFormField(
        autofocus: true,
        controller: controllerPergunta,
        decoration: const InputDecoration(
          labelText: "Informe a descrição da pergunta",
          border: OutlineInputBorder(),
        ),
      ),
      const SizedBox(
        height: 15,
      ),
      TextFormField(
        autofocus: true,
        controller: controllerValorInicial,
        decoration: const InputDecoration(
          labelText: "Informe o valor inicial para a resposta",
          border: OutlineInputBorder(),
        ),
      ),
      const SizedBox(
        height: 15,
      ),
      TextFormField(
        autofocus: true,
        controller: controllerValorFinal,
        decoration: const InputDecoration(
          labelText: "Informe o valor final para a resposta",
          border: OutlineInputBorder(),
        ),
      ),
      const SizedBox(
        height: 15,
      ),
      Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(3),
          border: Border.all(
            color: Colors.grey,
          ),
        ),
        child: SearchChoices.single(
          padding: const EdgeInsets.only(left: 10),
          hint: const Text("Tipo Resposta"),
          underline: Container(
            height: 0,
          ),
          isExpanded: true,
          items: const [
            DropdownMenuItem(value: 'd', child: Text("Decimal")),
            DropdownMenuItem(value: 's', child: Text("String")),
            DropdownMenuItem(value: 'b', child: Text("Boolean")),
          ],
          onChanged: (value) {
            valueTipoResposta = value;
          },
        ),
      ),
      const SizedBox(
        height: 15,
      ),
      TextFormField(
        autofocus: true,
        controller: controllerTamanhoTotal,
        decoration: const InputDecoration(
          labelText: "Informe o tamanho total",
          border: OutlineInputBorder(),
        ),
      ),
      const SizedBox(
        height: 15,
      ),
      Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(3),
          border: Border.all(
            color: Colors.grey,
          ),
        ),
        child: SearchChoices.single(
          padding: const EdgeInsets.only(left: 10),
          value: valueObrigatorio,
          underline: Container(
            height: 0,
          ),
          hint: const Text("Obrigatório"),
          isExpanded: true,
          items: const [
            DropdownMenuItem(value: true, child: Text('Sim')),
            DropdownMenuItem(value: false, child: Text('Não')),
          ],
          onChanged: (value) {
            valueObrigatorio = value;
            setState(() {});
          },
        ),
      ),
      const SizedBox(
        height: 15,
      ),
      Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(3),
          border: Border.all(
            color: Colors.grey,
          ),
        ),
        child: SearchChoices.multiple(
          padding: const EdgeInsets.only(left: 10),
          underline: Container(
            height: 0,
          ),
          hint: "<Multi Seleção Pesquisa>",
          isExpanded: true,
          items: items,
          onChanged: (value) {
            valuePesquisa = value;
          },
          selectedItems: valuePesquisa ?? [],
        ),
      ),
    ];
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
    if (widget.tipoCrud == TipoCrud.alterar){
      valuePesquisa = [listaPesquisa.indexWhere((element){
        return element.idPesquisa == widget.pesquisaPerguntaAlterar!.idPesquisa[0];
      })];
    }
    setState(() {});
  }

  @override
  Future<void> onGravar() async {
    var pesquisaPergunta = PesquisaPerguntaDAO(
      idPesquisaPergunta: int.tryParse(controllerCodigo.text),
      pergunta: controllerPergunta.text,
      valorInicial: double.parse(controllerValorInicial.text),
      valorFinal: double.parse(controllerValorFinal.text),
      tamanhoTotal: int.parse(controllerTamanhoTotal.text),
      tipoResposta: valueTipoResposta!,
      obrigatoria: valueObrigatorio!,
      idPesquisa: getListaPesquisaPost(),
    );

    if (widget.tipoCrud == TipoCrud.inserir) {
      await util_http.post(
          path: rotaPesquisaPergunta,
          jsonDAO: jsonEncode(pesquisaPergunta.toJson()),
          context: context);
    } else {
      await util_http.patch(
          path: rotaPesquisaPergunta,
          jsonDAO: jsonEncode(pesquisaPergunta.toJson()),
          context: context);
    }
  }

  List<int> getListaPesquisaPost(){
    List<int> listaPesquisaPost = [];
    for (var element in valuePesquisa!) {
      listaPesquisaPost.add(listaPesquisa.elementAt(element).idPesquisa!);
    }
    return listaPesquisaPost;
  }
}
