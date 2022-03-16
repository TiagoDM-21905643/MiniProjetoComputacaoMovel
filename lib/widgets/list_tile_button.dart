import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/registo_peso_model.dart';

class ListTileButton extends ListTile {
  final Function onPressed;
  final RegistoPeso registo;
  final Color color;

  ListTileButton({
    required this.onPressed,
    required this.registo,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(primary: color),
        onPressed: () => onPressed(),
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Data: ${registo.getDate()}",
                      style: const TextStyle(
                        fontSize: 20,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Peso: ${registo.peso.toString()}",
                      style: const TextStyle(
                        fontSize: 20,
                        color: Colors.black54,
                      ),
                    ),
                    Text(
                      "Sentia-se ${registo.aval.toString()} de 1 a 5",
                      style: const TextStyle(
                        fontSize: 20,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
