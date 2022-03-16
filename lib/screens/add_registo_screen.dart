import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:i_que_chumbei/blocs/i_que_chumbei_bloc.dart';
import 'package:i_que_chumbei/models/registo_peso_model.dart';
import 'package:i_que_chumbei/screens/lista_registos_screen.dart';

class AddRegistoScreen extends StatelessWidget {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late double peso;
  int aval = 1;
  late String obs;
  bool checkBoxFood3h = false;

  final String title;
  final IQueChumbeiBloc bloc;

  AddRegistoScreen({
    Key? key,
    required this.title,
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
              child: Text("Peso:", textScaleFactor: 1.5,),
            ),
            TextFormField(
              keyboardType: TextInputType.number,
              onSaved: (String? value) { peso = double.parse(value ?? ""); },
              decoration: const InputDecoration(
                hintText: 'Insira o seu peso em Kg',
              ),
              validator: (String? value) {
                if (value == null || value.isEmpty || double.tryParse(value) == null) {
                  return 'Please enter a valid number of Kg';
                }
                return null;
              },
            ),
            Row (
              children: [
                const SizedBox( width: 15, ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: StatefulBuilder(
                    builder: (BuildContext context, StateSetter setState) {
                      return SizedBox(
                        width: 40,
                        height: 40,
                        child: DropdownButtonFormField(
                          value: aval,
                          icon: const Icon(Icons.arrow_downward),
                          elevation: 16,
                          items: [1, 2, 3, 4, 5].map((int value) {
                            return DropdownMenuItem(
                              value: value,
                              child: Text(value.toString(),),
                            );
                          }).toList(),
                          onChanged: (int? newValue) {setState(() { aval = newValue ?? 1; });},
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox( width: 20, ),
                const Padding(
                  padding: EdgeInsets.only(top: 35),
                  child: Text("Como se sente hoje?", textScaleFactor: 1.5,),
                ),
              ],
            ),
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: StatefulBuilder(
                    builder: (BuildContext context, StateSetter setState) {
                      return Checkbox(
                        value: checkBoxFood3h,
                        onChanged: (bool? newValue) {
                          setState(() { checkBoxFood3h = newValue!; });
                        },
                      );
                    },
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: Text("Alimentou-se nas últimas 3 horas?", textScaleFactor: 1.5,),
                ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.only(top: 20),
              child: Text("Observações: ", textScaleFactor: 1.5,),
            ),
            TextFormField(
              keyboardType: TextInputType.multiline,
              minLines: 1,
              onSaved: (String? value) { obs = value ?? ""; },
              decoration: const InputDecoration(
                hintText: 'Escreva de 100 a 200 caracteres (opcional)',
              ),
              validator: (String? value) {
                if (value == null || 99 < value.length && value.length < 201) {
                  return 'O texto tem que ter entre 100 e 200 letras';
                }
                return null;
              },
            ),
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.all(20),
              child: ElevatedButton(
                child: const Text('Registar'),
                onPressed: () {
                  if (_formKey.currentState != null && _formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    RegistoPeso registoPeso = RegistoPeso(peso, checkBoxFood3h, aval, obs: obs);
                    bloc.registos.add(registoPeso);
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return const AlertDialog(
                          content: Text('O seu registo foi submetido com sucesso.'),
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