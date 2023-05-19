import 'package:flutter/material.dart';
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
                  const PopupMenuItem(child: Text('Configurações')),
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
                  onTap: _searchHappiness,
                ),
                ListTile(
                  title: const Text('Cerimonia'),
                  onTap: () {},
                ),
              ],
            ),
          ],
        ),
      ),
      body: const Center(child: Text('Vamo Detonar Diogo')),
    );
  }

  void _searchHappiness(){
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context){
        return const ConfiguracaoNotaFelicidade();
      }),
    );
  }
}
