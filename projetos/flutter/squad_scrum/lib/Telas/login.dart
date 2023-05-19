import 'package:flutter/material.dart';
import 'package:squad_scrum/Telas/menu_principal.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: SizedBox(
            width: 500,
            height: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const TextField(
                  autofocus: true,
                  decoration: InputDecoration(
                    labelText: 'Informe o Usuário',
                    labelStyle: TextStyle(
                      fontSize: 20  ,
                    ),
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 20),
                const TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Informe a Senha',
                    labelStyle: TextStyle(
                      fontSize: 20,
                    ),
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  height: 50,
                  width: 200,
                  child: ElevatedButton(
                    style: TextButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    onPressed: _menuPrincipal,
                    child: const Text('Acessar'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _menuPrincipal(){
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context){
        return const MenuPrincipal();
      }),
    );
  }
}
