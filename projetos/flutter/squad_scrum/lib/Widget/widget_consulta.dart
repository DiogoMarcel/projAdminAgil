import 'package:flutter/material.dart';

class WidgetConsulta extends StatelessWidget {
  final VoidCallback onInsert;
  final Widget body;
  final String appBarTitle;

  const WidgetConsulta(
      {Key? key,
      required this.onInsert,
      required this.body,
      required this.appBarTitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(appBarTitle),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: onInsert,
        child: const Icon(Icons.add),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: body,
      ),
    );
  }
}
