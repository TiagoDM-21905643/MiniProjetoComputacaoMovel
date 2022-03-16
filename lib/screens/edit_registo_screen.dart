import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:i_que_chumbei/blocs/i_que_chumbei_bloc.dart';
import 'package:i_que_chumbei/models/registo_peso_model.dart';

import 'lista_registos_screen.dart';

class EditRegistoScreen extends StatelessWidget {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final String title;
  final RegistoPeso registo;
  final IQueChumbeiBloc bloc;

  EditRegistoScreen({
    Key? key,
    required this.title,
    required this.registo,
    required this.bloc,
  }) : super (key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title),),
      body: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.only(top: 20),
              child: Text("Peso:", textScaleFactor: 2,),
            ),
            TextFormField(
              initialValue: registo.peso.toString(),
              onSaved: (String? value) { registo.peso = double.parse(value ?? ""); },
              decoration: const InputDecoration(
                hintText: 'Insira o seu peso em Kg',
              ),
              validator: (String? value) {
                if (value == null || value.isEmpty || double.tryParse(value) == null) {
                  return 'Please enter a number';
                }
                return null;
              },
            ),
            const Padding(
              padding: EdgeInsets.only(top: 20),
              child: Text("Como se sente hoje?", textScaleFactor: 2,),
            ),
            TextFormField(
              initialValue: registo.aval.toString(),
              onSaved: (String? value) { registo.aval = int.parse(value ?? ""); },
              decoration: const InputDecoration(
                hintText: 'Insira um número de 1 a 5',
              ),
              validator: (String? value) {
                if (value == null || value.isEmpty || int.tryParse(value) == null
                    || int.parse(value) < 1 || int.parse(value) > 5) {
                  return 'Please enter a number';
                }
                return null;
              },
            ),
            const Padding(
              padding: EdgeInsets.only(top: 20),
              child: Text("Observações: ", textScaleFactor: 2,),
            ),
            TextFormField(
              initialValue: registo.obs.toString(),
              onSaved: (String? value) { registo.obs = value ?? ""; },
              decoration: const InputDecoration(
                hintText: 'Escreva aqui as suas observações (opcional)',
              ),
            ),
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: StatefulBuilder(
                    builder: (BuildContext context, StateSetter setState) {
                      return Checkbox(
                        value: registo.foodLast3h,
                        onChanged: (bool? newValue) {
                          setState(() {
                            registo.foodLast3h = newValue!;
                          });
                        },
                      );
                    },
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: Text("Alimentou-se nas últimas 3 horas?",),
                ),
              ],
            ),
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.all(20),
              child: ElevatedButton(
                child: const Text('Registar'),
                onPressed: () {
                  if (_formKey.currentState != null && _formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ListaRegistosScreen(title: "Registos de Peso", bloc: bloc,)),
                    );
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return const AlertDialog(
                          content: Text('O registo selecionado foi editado com sucesso.'),
                        );
                      }
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}