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

class _CadastroPesquisaPerguntaState extends BaseStateInclusao<CadastroPesquisaPergunta> {
  TextEditingController controllerCodigo = TextEditingController();
  TextEditingController controllerPergunta = TextEditingController();
  TextEditingController controllerValorInicial = TextEditingController();
  TextEditingController controllerValorFinal = TextEditingController();
  TextEditingController controllerTipoResposta = TextEditingController();
  TextEditingController controllerTamanhoTotal = TextEditingController();
  TextEditingController controllerObrigatoria = TextEditingController();
  TextEditingController controllerPesquisa = TextEditingController();

  List<PesquisaDAO> listaPesquisa = [];
  List<DropdownMenuItem> items = [];

  @override
  void initState() {
    super.initState();
    super.objetoPostgres = "Pesquisa Pergunta";
    super.tipoCrud = widget.tipoCrud;
    if (widget.tipoCrud == TipoCrud.alterar) {
      // controllerCodigo.text = widget.sprintAlterar!.idSprint.toString();
      // controllerNome.text = widget.sprintAlterar!.nome;
      // dataInicio = widget.sprintAlterar!.dataInicio;
      // dataFinal = widget.sprintAlterar!.dataFinal;
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
        controller: controllerPergunta,
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
        controller: controllerPergunta,
        decoration: const InputDecoration(
          labelText: "Informe o valor final para a resposta",
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
          labelText: "Decimal/String/Bool Informe o tipo da resposta",
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
          labelText: "Informe o tamanho total",
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
          labelText: "Sim/Não Obrigatoria",
          border: OutlineInputBorder(),
        ),
      ),
      const SizedBox(
        height: 15,
      ),
      Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey,),
        ),
        child: SearchChoices.multiple(
          underline: Container(
            height: 0,
          ),
          hint: "<Multi Seleção Pesquisa>",
          isExpanded: true,
          items: items,
          //value: e.idPesquisa,
          onChanged: () {},
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
    setState(() {});
  }

  @override
  void onGravar() {}
}
