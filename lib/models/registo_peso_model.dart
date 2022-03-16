import 'package:intl/intl.dart';

class RegistoPeso {

  double peso;
  bool foodLast3h;
  int aval;
  String obs;
  DateTime dateTime = DateTime.now();

  RegistoPeso(this.peso, this.foodLast3h, this.aval, {this.obs = ""});

  String getDate() {
    return DateFormat("dd-MM-yyyy").format(dateTime);
  }
}