// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:projecte_uno/clases/Jugador.dart';
import 'package:projecte_uno/clases/Partida.dart';
import 'package:projecte_uno/pantallas/pantallaJuego/CartasMesa.dart';
import 'package:projecte_uno/pantallas/pantallaJuego/CartasMano.dart';
import 'package:projecte_uno/pantallas/pantallaJuego/Robar.dart';
import 'package:projecte_uno/pantallas/pantallaJuego/UNO.dart';
import 'package:projecte_uno/pantallas/pantallaJuego/boton_abandonar.dart';

class PantallaJuego extends StatelessWidget {
  final mano = ["b0", "y4", "r8", "g7", "g9", "r3", "b2", "k%", "y5", "y4"];
  final mesa = ["b1", "y5", "r9", "g8", "g0", "r4", "b3"];

  PantallaJuego({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black87,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Align(
            child: Abandonar(),
            alignment: Alignment.topLeft,
          ),
          Spacer(),
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 8),
              child: Row(
                children: [
                  CartaMesa(carta: mesa),
                  Spacer(),
                  Column(
                    children: [
                      Spacer(),
                      UNO(j1: Jugador("pepe", true)),
                      Spacer(),
                      Robar(
                          j1: Jugador("pepe", true),
                          p1: Partida(Jugador("elHost", true))),
                      Spacer(),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: CartasMano(
              cartas: mano,
            ),
          )
        ],
      ),
    );
  }
}
