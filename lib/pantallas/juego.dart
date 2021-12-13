// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:projecte_uno/pantallas/pantallaJuego/CartasMano.dart';
import 'package:projecte_uno/pantallas/pantallaJuego/boton_abandonar.dart';

class PantallaJuego extends StatelessWidget {
  final mano = ["b0", "y4", "r8", "g7", "g9", "r3", "b2", "k%", "y5", "y4"];

  PantallaJuego({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Align(
          child: Abandonar(),
          alignment: Alignment.topLeft,
        ),
        Spacer(flex: 2),
        Expanded(
          child: CartasMano(
            cartas: mano,
          ),
        )
      ],
    );
  }
}
