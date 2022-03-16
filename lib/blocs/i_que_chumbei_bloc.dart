import 'dart:developer';

import '../models/registo_peso_model.dart';

class IQueChumbeiBloc {

  final List<RegistoPeso> registos = [
    RegistoPeso(100, true , 4),
    RegistoPeso(100, true , 4),
    RegistoPeso(99, false, 3),
    RegistoPeso(99, true , 4),
    RegistoPeso(99, true , 4),
    RegistoPeso(99, false, 3),
    RegistoPeso(98, true , 4),
    RegistoPeso(97, true , 4),
    RegistoPeso(96, true , 4),
    RegistoPeso(95, false, 3),
    RegistoPeso(95, true , 4),
    RegistoPeso(95, true , 4),
    RegistoPeso(95, false, 3),
    RegistoPeso(95, true , 4),
    RegistoPeso(95, true , 3),
    RegistoPeso(95, true , 3),
    RegistoPeso(97, false, 2),
    RegistoPeso(98, true , 3),
    RegistoPeso(98, true , 3),
    RegistoPeso(97, false, 2),
    RegistoPeso(96, true , 3),
    RegistoPeso(95, true , 2),
    RegistoPeso(94, true , 2),
    RegistoPeso(94, false, 1),
    RegistoPeso(93, true , 2),
    RegistoPeso(92, true , 2),
    RegistoPeso(91, false, 1),
    RegistoPeso(90, true , 2),
    RegistoPeso(89, true , 1),
    RegistoPeso(87, true , 1),
  ];

  void orderRegistosByDate() {
    registos.sort((a, b) {
      return a.dateTime.isAfter(b.dateTime) ? 0 : 1;
    });
  }

  List<RegistoPeso> getRegistoBetweenDates(DateTime start, DateTime end) {
    List<RegistoPeso> registosLastXDays = [];
    for (final registo in registos) {
      if (registo.dateTime.isAfter(start) && registo.dateTime.isBefore(end)) {
        registosLastXDays.add(registo);
      }
    }
    return registosLastXDays;
  }

  double getMediaPesoBetweenDates(DateTime start, DateTime end) {
    List<RegistoPeso> registosLastXDays = getRegistoBetweenDates(start, end);
    double soma = 0;
    for (final registo in registosLastXDays) { soma += registo.peso; }
    return soma / registosLastXDays.length;
  }
  double getMediaPesoLastXDays(int days) => getMediaPesoBetweenDates(DateTime.now().subtract(Duration(days: days)), DateTime.now());

  double getMediaAvalBetweenDates(DateTime start, DateTime end) {
    List<RegistoPeso> registosLastXDays = getRegistoBetweenDates(start, end);
    double soma = 0;
    for (final registo in registosLastXDays) { soma += registo.aval; }
    return soma / registosLastXDays.length;
  }
  double getMediaAvalLastXDays(int days) => getMediaAvalBetweenDates(DateTime.now().subtract(Duration(days: days)), DateTime.now());

  RegistoPeso getFirstRegistoPeso() => registos[0];
  RegistoPeso getLastRegistoPeso() => registos[registos.length - 1];

  double getVariacaoPesoMediaLastWeek() {
    double mediaFirstWeek = getMediaPesoBetweenDates(DateTime.now().subtract(Duration(days: 14)), DateTime.now().subtract(Duration(days: 8)));
    double mediaSecondWeek = getMediaPesoLastXDays(7);

    return (mediaSecondWeek - mediaFirstWeek) * 100 / mediaFirstWeek;
  }
}