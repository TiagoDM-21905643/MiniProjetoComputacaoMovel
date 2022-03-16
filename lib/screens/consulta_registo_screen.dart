import 'package:flutter/material.dart';
import 'package:i_que_chumbei/blocs/i_que_chumbei_bloc.dart';
import 'package:i_que_chumbei/models/registo_peso_model.dart';

class ConsultaRegistoScreen extends StatelessWidget {

  final String title;
  final RegistoPeso registo;
  final IQueChumbeiBloc bloc;

  const ConsultaRegistoScreen({
    Key? key,
    required this.registo,
    required this.title,
    required this.bloc,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title),),
      body: Column (
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: Padding(
              padding: const EdgeInsets.only(left: 10, right:10, bottom:10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Data: ",
                    style: TextStyle(fontSize: 25,),
                  ),
                  Text(
                    registo.getDate(),
                    style: const TextStyle(fontSize: 25,),
                  ),
                ],
              )
            ),
          ),
          Container(
            child: Padding(
              padding: const EdgeInsets.only(left: 10, right:10, bottom:10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Peso: ",
                    style: TextStyle(fontSize: 25,),
                  ),
                  Text(
                    registo.peso.toString(),
                    style: const TextStyle(fontSize: 25,),
                  ),
                ],
              )
            ),
          ),
          Container(
            child: Padding(
              padding: const EdgeInsets.only(left: 10, right:10, bottom:10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Alimentou-se nas últimas 3 horas?",
                    style: TextStyle(fontSize: 20,),
                  ),
                  Text(
                    registo.foodLast3h.toString(),
                    style: const TextStyle(fontSize: 20,),
                  ),
                ],
              )
            ),
          ),
          Container(
            child: Padding(
                padding: const EdgeInsets.only(left: 10, right:10, bottom:10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Como se sentia no dia em questão?",
                      style: TextStyle(fontSize: 20,),
                    ),
                    Text(
                      registo.aval.toString(),
                      style: const TextStyle(fontSize: 20,),
                    ),
                  ],
                )
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, right:10, bottom:10),
            child: Column(
              children: [
                Text(
                  registo.obs != "" ? "Observações:" : "Sem Observações",
                  style: const TextStyle(fontSize: 20,),
                ),
                Text(
                  registo.obs != "" ? registo.obs : "",
                  style: const TextStyle(fontSize: 15,),
                ),
              ],
            )
          ),
        ],
      ),
    );
  }
}