// ignore_for_file: file_names, prefer_const_constructors, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:projecte_uno/pantallas/pantallaJuego/build_carta.dart';

class StackedCards extends StatefulWidget {
  late final List<String> cartas;

  StackedCards({Key? key, required this.cartas}) : super(key: key);

  @override
  _StackedCardsState createState() => _StackedCardsState();
}

class _StackedCardsState extends State<StackedCards> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        return Align(
          alignment: Alignment.topLeft,
          widthFactor: 0.45,
          child: Carta(codigo: widget.cartas[index]),
        );
      },
      itemCount: widget.cartas.length,
    );
  }
}
