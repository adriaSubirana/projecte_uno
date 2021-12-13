// ignore_for_file: file_names, sized_box_for_whitespace, prefer_const_constructors, unused_import, must_be_immutable
import 'package:flutter/material.dart';
import 'package:projecte_uno/clases/Jugador.dart';
import 'package:projecte_uno/clases/Partida.dart';

late String cartamesaActualizada;

class CartaMesa extends StatelessWidget {
  late List<String> carta;
  late String ultcarta = carta.last;

  CartaMesa({
    Key? key,
    required this.carta,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 300,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('$ultcarta.png'),
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
