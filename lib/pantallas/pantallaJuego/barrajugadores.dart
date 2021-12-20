// ignore_for_file: prefer_const_constructors, unused_import, avoid_unnecessary_containers, camel_case_types

import 'package:flutter/material.dart';
import 'package:projecte_uno/clases/Jugador.dart';

class barrajugador extends StatelessWidget {
  final List<Jugador> jugadores;
  const barrajugador({
    Key? key,
    required this.jugadores,
  }) : super(key: key);

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
                child: showuser(
                    numcartas: jugadores[i].cartas.length,
                    nombre: jugadores[i].nombre),
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
            Icon(Icons.person, color: Colors.black, size: 50),
            Container(
              width: 50,
              height: 50,
              alignment: Alignment.topRight,
              child: Container(
                  width: 15,
                  height: 15,
                  decoration:
                      BoxDecoration(shape: BoxShape.circle, color: Colors.red),
                  child: Center(
                      child: Text("$numcartas",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 12)))),
            ),
          ],
        ),
        Text("$nombre",
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 11)),
      ],
    );
  }
}
