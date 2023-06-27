import 'package:intl/intl.dart';

class Funcoes {
  static bool validarEmail(String value){
    return RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$').hasMatch(value);
  }

  static bool isValidDateTimeString(String dateTimeString) {
    try {
      DateFormat dateFormat = DateFormat("dd-MM-yyyy");
      dateFormat.parse(dateTimeString);
      return true;
    } catch (e) {
      return false;
    }
  }
}