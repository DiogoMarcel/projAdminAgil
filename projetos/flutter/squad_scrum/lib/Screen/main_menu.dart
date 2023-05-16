import 'package:flutter/material.dart';
import 'package:squad_scrum/Screen/search_happiness.dart';

class MainMenu extends StatefulWidget {
  const MainMenu({Key? key}) : super(key: key);

  @override
  State<MainMenu> createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
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
        return const SearchHappiness();
      }),
    );
  }
}
