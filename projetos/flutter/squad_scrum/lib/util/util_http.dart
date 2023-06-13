import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:squad_scrum/Consts/consts.dart';

Future<dynamic> get({required String path, required BuildContext context}) async {
  Uri url = Uri.http(ipServer, path);
  var response = await http.get(url);
  if(response.statusCode == 200){
    return jsonDecode(response.body);
  }else{
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro ao Gravar os Dados ${response.body}')));
    }
    throw Exception(response.body);
  }
}

Future<dynamic> post({required String path, required String jsonDAO, required BuildContext context}) async {
  Uri url = Uri.http(ipServer, path);
  var response = await http.post(url, body: jsonDAO);
  if(response.statusCode == 200){
    return jsonDecode(response.body);
  } else {
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Erro ao Gravar os Dados ${response.body}')));
    }
    throw Exception(response.body);
  }
}

Future<void> patch({required String path, required String jsonDAO, required BuildContext context}) async {
  Uri url = Uri.http(ipServer, path);
  var response = await http.patch(url, body: jsonDAO);
  if(response.statusCode != 200){
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro ao Gravar os Dados ${response.body}')));
    }
    throw Exception(response.body);
  }
}

Future<void> delete({required String path, required String jsonDAO, required BuildContext context}) async {
  Uri url = Uri.http(ipServer, path);
  var response = await http.delete(url, body: jsonDAO);
  if(response.statusCode != 200){
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro ao Gravar os Dados ${response.body}')));
    }
    throw Exception(response.body);
  }
}
