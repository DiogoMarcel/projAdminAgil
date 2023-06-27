import 'package:flutter/material.dart';

class BaseConsulta extends StatefulWidget {
  final List<DataColumn> listaDataColumn;
  final List<dynamic> listaDados;
  final List<DataCell> Function(dynamic) processarColunas;
  final VoidCallback onButtonInserir;
  final void Function(int) onAlterar;
  final void Function(int) onDeletar;
  final bool sortAscending;
  final int? sortColumnIndex;

  const BaseConsulta({
    Key? key,
    required this.listaDataColumn,
    required this.listaDados,
    required this.processarColunas,
    required this.onButtonInserir,
    required this.onAlterar,
    required this.onDeletar,
    required this.sortAscending,
    required this.sortColumnIndex,
  }) : super(key: key);

  @override
  State<BaseConsulta> createState() => _BaseConsultaState();
}

class _BaseConsultaState extends State<BaseConsulta> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: widget.onButtonInserir,
          child: const Icon(Icons.add),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: SingleChildScrollView(
              child: DataTable(
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 1,
                  ),
                ),
                showBottomBorder: true,
                dividerThickness: 2,
                showCheckboxColumn: false,
                sortAscending: widget.sortAscending,
                sortColumnIndex: widget.sortColumnIndex,
                columns: widget.listaDataColumn +
                    [const DataColumn(label: Text(""))],
                rows: listaDataRow(),
              ),
            ),
          ),
        ),
      ),
    );
  }

  List<DataRow> listaDataRow() {
    return widget.listaDados
        .map(
          (e) => DataRow(
            color: MaterialStateProperty.resolveWith<Color?>(
              (Set<MaterialState> states) {
                if (states.contains(MaterialState.selected)) {
                  return Theme.of(context)
                      .colorScheme
                      .primary
                      .withOpacity(0.08);
                }
                if (widget.listaDados.indexOf(e).isEven) {
                  return Colors.grey.withOpacity(0.3);
                }
                return null;
              },
            ),
            cells: widget.processarColunas(e) +
                [
                  DataCell(
                    Row(
                      children: [
                        InkWell(
                          child: const Icon(
                            Icons.edit,
                            color: Colors.black87,
                            size: 22,
                          ),
                          onTap: (){
                            widget.onAlterar(widget.listaDados.indexOf(e));
                          },
                        ),
                        const SizedBox(width: 10,),
                        InkWell(
                          child: const Icon(
                            Icons.delete,
                            color: Colors.red,
                            size: 22,
                          ),
                          onTap: (){
                            widget.onDeletar(widget.listaDados.indexOf(e));
                          },
                        ),
                      ],
                    ),
                  ),
                ],
          ),
        )
        .toList();
  }
}
