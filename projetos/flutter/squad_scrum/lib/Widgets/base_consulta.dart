import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';

class BaseConsulta extends StatefulWidget {
  String tituloTela;
  VoidCallback onButtonInserir;
  List<DataColumn> listaDataColumn;
  List<DataRow> listaDataRow;
  bool sortAscending;
  int? sortColumnIndex;

  BaseConsulta({
    Key? key,
    required this.tituloTela,
    required this.onButtonInserir,
    required this.listaDataColumn,
    required this.listaDataRow,
    required this.sortAscending,
    required this.sortColumnIndex,
  }) : super(key: key);

  @override
  State<BaseConsulta> createState() => _BaseConsultaState();
}

class _BaseConsultaState extends State<BaseConsulta> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.tituloTela),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: widget.onButtonInserir,
        child: const Icon(Icons.add),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: DataTable2(
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
            ),
          ),
          minWidth: 900,
          showBottomBorder: true,
          dividerThickness: 2,
          showCheckboxColumn: false,
          sortAscending: widget.sortAscending,
          sortColumnIndex: widget.sortColumnIndex,
          columns: widget.listaDataColumn,
          rows: widget.listaDataRow,
        ),
      ),
    );
  }
}
