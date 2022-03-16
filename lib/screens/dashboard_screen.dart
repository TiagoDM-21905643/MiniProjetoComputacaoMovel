import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:i_que_chumbei/widgets/line_chart_registos.dart';

import '../blocs/i_que_chumbei_bloc.dart';
import '../widgets/list_tile_button.dart';
import 'consulta_registo_screen.dart';

class DashBoardScreen extends StatefulWidget {
  final IQueChumbeiBloc bloc;
  final String title;

  DashBoardScreen({
    Key? key,
    required this.title,
    required this.bloc
  }) : super(key: key);

  @override
  _DashBoardPageState createState() => _DashBoardPageState();
}

class _DashBoardPageState extends State<DashBoardScreen> {

  @override
  Widget build(BuildContext context) {
    List<String> titles = [
      "Média do peso dos últimos 7 dias:",
      "Média do peso dos últimos 30 dias:",
      widget.bloc.getVariacaoPesoMediaLastWeek().isNaN ?
        "Não temos informação suficiente para calcular a\nvariação do peso médio dos últimos 7 dias."
          : "Variação do peso médio\ndos últimos 7 dias:",
      "Média do indicador\n\"como se sente hoje\" 7 dias:",
      "Média do indicador\n\"como se sente hoje\" 30 dias:",
    ];
    List<String> values = [
      "${widget.bloc.getMediaPesoLastXDays(7).toStringAsFixed(2)} Kg",
      "${widget.bloc.getMediaPesoLastXDays(30).toStringAsFixed(2)} Kg",
      widget.bloc.getVariacaoPesoMediaLastWeek().isNaN ?
        "" : "${widget.bloc.getVariacaoPesoMediaLastWeek().toStringAsFixed(2)} %",
      widget.bloc.getMediaAvalLastXDays(7).toStringAsFixed(2),
      widget.bloc.getMediaAvalLastXDays(30).toStringAsFixed(2),
    ];

    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            for (int index = 0; index < titles.length; index++) Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Container(
                      child: Padding(
                        padding: index == 0 ?
                        const EdgeInsets.only(left: 10, right:10, top:10, bottom:10)
                            : const EdgeInsets.only(left: 10, right:10, bottom:10),
                        child: Text(
                          titles[index],
                          style: const TextStyle(fontSize: 17,),
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Container(
                      child: Padding(
                        padding: index == 0 ?
                        const EdgeInsets.only(left: 10, right:10, top:10, bottom:10)
                            : const EdgeInsets.only(left: 10, right:10, bottom:10),
                        child: Text(
                          values[index],
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: index == 3 ? (widget.bloc.getMediaAvalLastXDays(7) > 2 ? Colors.green : Colors.red)
                                : index == 4 ? (widget.bloc.getMediaAvalLastXDays(30) > 2 ? Colors.green : Colors.red)
                                : Colors.black54,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const Divider(
              height: 25,
              thickness: 3,
              color: Colors.black54,
            ),
            if (widget.bloc.registos.isNotEmpty) const Text(
              "Primeiro Registo",
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Colors.black54,
              ),
            ),
            if (widget.bloc.registos.isNotEmpty) Padding(
              padding: const EdgeInsets.only(left: 10, right:10, bottom:10),
              child: ListTileButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ConsultaRegistoScreen(
                        title: "Consulta Registo",
                        registo: widget.bloc.registos[widget.bloc.registos.length - 1],
                        bloc: widget.bloc,
                      ),
                    ),
                  );
                },
                registo: widget.bloc.registos[widget.bloc.registos.length - 1],
                color: Colors.white30,
              ),
            ),
            if (widget.bloc.registos.isNotEmpty) const Text(
              "Último Registo",
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Colors.black54,
              ),
            ),
            if (widget.bloc.registos.isNotEmpty) Padding(
              padding: const EdgeInsets.only(left: 10, right:10, bottom:10),
              child: ListTileButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ConsultaRegistoScreen(
                        title: "Consulta Registo",
                        registo: widget.bloc.registos[0],
                        bloc: widget.bloc,
                      ),
                    ),
                  );
                },
                registo: widget.bloc.registos[0],
                color: Colors.white30,
              ),
            ),
            const Divider(
              height: 25,
              thickness: 3,
              color: Colors.black54,
            ),
            if (widget.bloc.registos.isNotEmpty) const Text(
              "15 Últimos Registos",
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Colors.black54,
              ),
            ),
            Container(
              height: 400,
              child: LineChartRegistos(bloc: widget.bloc),
            )
          ],
        ),
      ),
    );
  }
}
