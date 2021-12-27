// ignore_for_file: prefer_const_constructors, unused_import, avoid_unnecessary_containers, camel_case_types

import 'package:flutter/material.dart';
import 'package:projecte_uno/clases/Jugador.dart';
import 'package:projecte_uno/clases/Partida.dart';

class barrajugador extends StatelessWidget {
  final List<Jugador> jugadores;
  final int turno;
  const barrajugador({
    Key? key,
    required this.jugadores,
    required this.turno,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            for (int i = 0; i < jugadores.length; i++)
              Container(
                width: 55,
                height: 75,
                child: showuser(numcartas: jugadores[i].cartas.length, nombre: jugadores[i].nombre),
                decoration: i == turno
                    ? BoxDecoration(
                        color: Colors.grey[800],
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.lime,
                            spreadRadius: 7,
                            blurRadius: 7,
                          )
                        ],
                      )
                    : null,
              )
          ],
        ),
      ),
    );
  }
}

class showuser extends StatelessWidget {
  final int numcartas;
  final String nombre;
  const showuser({
    required this.numcartas,
    required this.nombre,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 3, 3, 0),
              child: Icon(Icons.person, color: Colors.white.withAlpha(200), size: 55),
            ),
            Container(
              width: 55,
              height: 55,
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 2, 2, 0),
                child: Container(
                    width: 15,
                    height: 15,
                    decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.red),
                    child: Center(
                        child: Text("$numcartas",
                            style: TextStyle(
                                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12)))),
              ),
            ),
          ],
        ),
        Text(nombre, style: TextStyle(color: Colors.white.withAlpha(200), fontSize: 11)),
      ],
    );
  }
}
