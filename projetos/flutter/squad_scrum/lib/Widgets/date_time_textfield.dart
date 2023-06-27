import 'package:easy_mask/easy_mask.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:squad_scrum/util/funcoes.dart';

class DateTimeTextField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;

  const DateTimeTextField({super.key, required this.controller, required this.hintText});

  @override
  State<DateTimeTextField> createState() => _DateTimeStringState();
}

class _DateTimeStringState extends State<DateTimeTextField> {
  FocusNode iconButtonFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    iconButtonFocusNode.skipTraversal = true;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: onValidarData,
      controller: widget.controller,
      keyboardType: TextInputType.number,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        TextInputMask(
          mask: "99-99-9999",
        ),
      ],
      decoration: InputDecoration(
        hintText: widget.hintText,
        counterText: "",
        filled: true,
        fillColor: Colors.white,
        border: const OutlineInputBorder(),
        suffixIcon: InkWell(
          child: const Icon(
            Icons.calendar_month,
            size: 22,
          ),
          onTap: () async {
            final DateTime? pickedDate = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(2000),
              lastDate: DateTime(2030),
            );

            if (pickedDate != null) {
              setState(() {
                widget.controller.text =
                    DateFormat("dd-MM-yyyy").format(pickedDate);
              });
            }
          },
        ),
      ),
    );
  }

  String? onValidarData(value) {
    if (!Funcoes.isValidDateTimeString(value.toString())) {
      return "Obrigatório";
    }
    return null;
  }
}

