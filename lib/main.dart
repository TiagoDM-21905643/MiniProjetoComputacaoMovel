import 'package:i_que_chumbei/blocs/i_que_chumbei_bloc.dart';
import 'package:i_que_chumbei/models/registo_peso_model.dart';
import 'package:i_que_chumbei/screens/add_registo_screen.dart';
import 'package:i_que_chumbei/screens/dashboard_screen.dart';
import 'package:i_que_chumbei/screens/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:i_que_chumbei/screens/lista_registos_screen.dart';

void main() {
  final app = iQueChumbei();
  app.initState();
  runApp(app);
}

class iQueChumbei extends StatelessWidget {
  final IQueChumbeiBloc bloc = IQueChumbeiBloc();

  void initState() {
    for (int days = bloc.registos.length - 1; days >= 0; days--) {
      bloc.registos[days].dateTime = DateTime.now().subtract(Duration(days: days));
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'IQueChumbei',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MainScreen(
        screens: [
          DashBoardScreen(title: "DashBoard", bloc: bloc,),
          AddRegistoScreen(title: "Novo Registo", bloc: bloc),
          ListaRegistosScreen(title: "Registos de Peso", bloc: bloc,),
        ],
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.dashboard),
              label: "DashBoard"
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.add),
              label: "Novo Registo"
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.notes),
              label: "Registos de Peso"
          ),
        ],
      ),
    );
  }
}
