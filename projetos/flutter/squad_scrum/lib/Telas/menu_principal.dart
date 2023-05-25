import 'package:flutter/material.dart';
import 'package:squad_scrum/Cadastros/consulta_cargo.dart';
import 'package:squad_scrum/Cadastros/consulta_empresa.dart';
import 'package:squad_scrum/Cadastros/consulta_equipe.dart';
import 'package:squad_scrum/Telas/configuracao_nota_felicidade.dart';

class MenuPrincipal extends StatefulWidget {
  const MenuPrincipal({Key? key}) : super(key: key);

  @override
  State<MenuPrincipal> createState() => _MainMenuState();
}

class _MainMenuState extends State<MenuPrincipal> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          PopupMenuButton(
              onSelected: (context) {},
              itemBuilder: (context) {
                return <PopupMenuEntry>[
                  const PopupMenuItem(child: Text('Configurações'),),
                ];
              }),
        ],
      ),
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
                  title: const Text('Pesquisa Felicidade'),
                  onTap: pesquisaFelicidade,
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
                  title: const Text('Equipe'),
                  onTap: consultaEquipe,
                ),
                ListTile(
                  title: const Text('Cargo'),
                  onTap: consultaCargo,
                ),
                ListTile(
                  title: const Text('Empresa'),
                  onTap: consultaEmpresa,
                ),
              ],
            ),
          ],
        ),
      ),
      body: const Center(child: Text('Vamo Detonar Diogo')),
    );
  }

  void pesquisaFelicidade(){
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context){
        return const ConfiguracaoNotaFelicidade();
      }),
    );
  }

  void consultaEquipe(){
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context){
        return const ConsultaEquipe();
      }),
    );
  }

  void consultaCargo(){
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context){
        return const ConsultaCargo();
      }),
    );
  }

  void consultaEmpresa(){
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context){
        return const ConsultaEmpresa();
      }),
    );
  }
}
