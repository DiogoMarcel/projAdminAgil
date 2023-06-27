import 'package:flutter/material.dart';
import 'package:squad_scrum/Cadastros/consulta_cargo.dart';
import 'package:squad_scrum/Cadastros/consulta_colaborador.dart';
import 'package:squad_scrum/Cadastros/consulta_empresa.dart';
import 'package:squad_scrum/Cadastros/consulta_equipe.dart';
import 'package:squad_scrum/Cadastros/consulta_funcao.dart';
import 'package:squad_scrum/Cadastros/consulta_pesquisa.dart';
import 'package:squad_scrum/Cadastros/consulta_pesquisa_pergunta.dart';
import 'package:squad_scrum/Cadastros/consulta_sprint.dart';

class MenuPrincipal extends StatefulWidget {
  const MenuPrincipal({Key? key}) : super(key: key);

  @override
  State<MenuPrincipal> createState() => _MainMenuState();
}

class _MainMenuState extends State<MenuPrincipal> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  int indexConsulta = 7;
  List<Widget> listaConsultas = [
    Container(),
    const ConsultaEquipe(),
    const ConsultaCargo(),
    const ConsultaEmpresa(),
    const ConsultaFuncao(),
    const ConsultaColaborador(),
    const ConsultaPesquisa(),
    const ConsultaSprint(),
    const ConsultaPesquisaPergunta(),
  ];

  List<String> listaNomesMenu = [
    "",
    "Equipe",
    "Cargo",
    "Empresa",
    "Função",
    "Colaborador",
    "Pesquisa",
    "Sprint",
    "Pesquisa Pergunta",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      drawer: Drawer(
        child: Column(
          children: [
            ExpansionTile(
              title: const Text('Retrospectiva'),
              childrenPadding: const EdgeInsets.only(left: 40),
              children: [
                ListTile(
                  title: const Text('Configurar Pesquisa Satisfação'),
                  onTap: () {},
                ),
                ListTile(
                  title: const Text('Cerimonia'),
                  onTap: () {},
                ),
              ],
            ),
            ExpansionTile(
              title: const Text('Cadastros'),
              childrenPadding: const EdgeInsets.only(left: 40),
              children: [
                ListTile(
                  title: Text(listaNomesMenu[1]),
                  onTap: () {
                    setIndexConsultaETitulo(1);
                  },
                ),
                ListTile(
                  title: Text(listaNomesMenu[2]),
                  onTap: () {
                    setIndexConsultaETitulo(2);
                  },
                ),
                ListTile(
                  title: Text(listaNomesMenu[3]),
                  onTap: () {
                    setIndexConsultaETitulo(3);
                  },
                ),
                ListTile(
                  title: Text(listaNomesMenu[4]),
                  onTap: () {
                    setIndexConsultaETitulo(4);
                  },
                ),
                ListTile(
                  title: Text(listaNomesMenu[5]),
                  onTap: () {
                    setIndexConsultaETitulo(5);
                  },
                ),
                ListTile(
                  title: Text(listaNomesMenu[6]),
                  onTap: () {
                    setIndexConsultaETitulo(6);
                  },
                ),
                ListTile(
                  title: Text(listaNomesMenu[7]),
                  onTap: () {
                    setIndexConsultaETitulo(7);
                  },
                ),
                ListTile(
                  title: Text(listaNomesMenu[8]),
                  onTap: () {
                    setIndexConsultaETitulo(8);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
      appBar: AppBar(
        actions: [
          PopupMenuButton(
            onSelected: (context) {},
            itemBuilder: (context) {
              return <PopupMenuEntry>[
                const PopupMenuItem(
                  child: Text('Configurações'),
                ),
              ];
            },
          ),
        ],
        title: indexConsulta > 0
            ? Text("Consulta ${listaNomesMenu[indexConsulta]}")
            : null,
      ),
      body: listaConsultas[indexConsulta],
    );
  }

  void setIndexConsultaETitulo(int index) {
    setState(() {
      indexConsulta = index;
      scaffoldKey.currentState!.openEndDrawer();
    });
  }
}
