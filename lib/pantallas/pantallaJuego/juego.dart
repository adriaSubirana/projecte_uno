// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:projecte_uno/clases/Jugador.dart';
import 'package:projecte_uno/clases/Partida.dart';
import 'package:projecte_uno/pantallas/pantallaJuego/CartasMesa.dart';
import 'package:projecte_uno/pantallas/pantallaJuego/CartasMano.dart';
import 'package:projecte_uno/pantallas/pantallaJuego/Robar.dart';
import 'package:projecte_uno/pantallas/pantallaJuego/UNO.dart';
import 'package:projecte_uno/pantallas/pantallaJuego/barrajugadores.dart';
import 'package:projecte_uno/pantallas/pantallaJuego/boton_abandonar.dart';

class PantallaJuego extends StatelessWidget {
  final mano = ["b0", "y4", "r8", "g7", "g9", "r3", "b2", "k%", "y5", "y4"];
  final mesa = ["b1", "y5", "r9", "g8", "g0", "r4", "r3"];

  PantallaJuego({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black.withAlpha(170),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Align(
            child: Abandonar(),
            alignment: Alignment.topLeft,
          ),
          barrajugador(
            jugadores: [
              Jugador("pepe", true),
              Jugador("lisa", false),
              Jugador("jamito", false),
              Jugador("bea", false),
            ],
            turno: 2,
          ),
          Expanded(
            flex: 8,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                children: [
                  Expanded(
                    child: CartaMesa(carta: mesa),
                  ),
                  Column(
                    children: [
                      Spacer(),
                      UNO(j1: Jugador("pepe", true)),
                      Spacer(),
                      Robar(j1: Jugador("pepe", true), p1: Partida()),
                      Spacer(),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: CartasMano(
              cartas: mano,
            ),
          )
        ],
      ),
    );
  }
}