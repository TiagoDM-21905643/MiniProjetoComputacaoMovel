import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:flutter/material.dart';
import 'dart:math';

import 'package:i_que_chumbei/blocs/i_que_chumbei_bloc.dart';
import 'package:i_que_chumbei/models/registo_peso_model.dart';


class LineChartRegistos extends StatelessWidget {
  final IQueChumbeiBloc bloc;

  LineChartRegistos({required this.bloc});

  List<GraphPoint> getChartData() {
    bloc.orderRegistosByDate();
    List<GraphPoint> registos = [];
    for (int i = 0; i < (bloc.registos.length < 15 ? bloc.registos.length : 15); i++) {
      registos.add(GraphPoint(peso: bloc.registos[i].peso, dia: i + 1,));
    }
    return registos;
  }

  @override
  Widget build(BuildContext context) {
    final registos = getChartData();
    return SafeArea(
      child: Scaffold(
        body: SfCartesianChart(
          series: <ChartSeries>[
            AreaSeries <GraphPoint, double> (
              dataSource: registos,
              xValueMapper: (GraphPoint registos, _) => registos.dia,
              yValueMapper: (GraphPoint registos, _) => registos.peso,
            ),
          ],
        ),
      ),
    );
  }
}

class GraphPoint{
  final double peso;
  final double dia;

  GraphPoint({required this.peso, required this.dia});
}