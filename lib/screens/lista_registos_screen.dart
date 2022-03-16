import 'package:flutter/material.dart';
import 'package:i_que_chumbei/models/registo_peso_model.dart';
import 'package:i_que_chumbei/screens/edit_registo_screen.dart';
import 'package:i_que_chumbei/widgets/list_tile_button.dart';

import '../blocs/i_que_chumbei_bloc.dart';
import 'consulta_registo_screen.dart';

class ListaRegistosScreen extends StatelessWidget {
  final String title;
  final IQueChumbeiBloc bloc;

  const ListaRegistosScreen({
    Key? key,
    required this.title,
    required this.bloc
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bloc.orderRegistosByDate();
    return Scaffold(
      appBar: AppBar(title: Text(title),),
      body: ListView.builder(
        itemCount: bloc.registos.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: index == 0 ?
              const EdgeInsets.only(left: 10, right:10, top:10, bottom:10)
                : const EdgeInsets.only(left: 10, right:10, bottom:10),
            child: Dismissible(
              key: Key(bloc.registos[index].dateTime.toString()),
              direction: DismissDirection.horizontal,
              child: ListTileButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ConsultaRegistoScreen(
                        title: "Consulta Registo",
                        registo: bloc.registos[index],
                        bloc: bloc,
                      ),
                    ),
                  );
                },
                registo: bloc.registos[index],
                color: Colors.white30,
              ),
              background: Container(
                color: Colors.green,
                child: const Align(
                  child: Padding(
                    padding: EdgeInsets.only(left: 16),
                    child: Icon(Icons.edit),
                  ),
                  alignment: Alignment.centerLeft,
                ),
              ),
              secondaryBackground: Container(
                color: Colors.red,
                child: const Align(
                  child: Padding(
                    padding: EdgeInsets.only(right: 16),
                    child: Icon(Icons.delete),
                  ),
                  alignment: Alignment.centerRight,
                ),
              ),
              confirmDismiss: (direction) async {
                if (bloc.registos[index].dateTime.isAfter(DateTime.now().subtract(Duration(days: 7)))
                    && bloc.registos[index].dateTime.isBefore(DateTime.now())) {
                  if (direction == DismissDirection.startToEnd) {  // Edicao
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => EditRegistoScreen(
                          title: "Editar Registo", registo: bloc.registos[index], bloc: bloc,
                        ))
                    );
                  } else {  // Eliminacao
                    bloc.registos.removeAt(index);
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return const AlertDialog(
                            content: Text('O registo selecionado foi eliminado com sucesso.'),
                          );
                        }
                    );
                  }
                  return true;
                }
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        content: Text('Só podem ser ${direction == DismissDirection.startToEnd ? "editados" : "eliminados"} registos datados dos últimos 7 dias.'),
                      );
                    }
                );
                return false;
              },
            ),
          );
        },
      ),
    );
  }
}
