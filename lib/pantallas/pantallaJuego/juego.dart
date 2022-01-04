// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:projecte_uno/clases/Jugador.dart';
import 'package:projecte_uno/clases/Partida.dart';
import 'package:projecte_uno/pantallas/pantallaJuego/CartasMesa.dart';
import 'package:projecte_uno/pantallas/pantallaJuego/CartasMano.dart';
import 'package:projecte_uno/pantallas/pantallaJuego/robar.dart';
import 'package:projecte_uno/pantallas/pantallaJuego/uno.dart';
import 'package:projecte_uno/pantallas/pantallaJuego/barrajugadores.dart';
import 'package:projecte_uno/pantallas/pantallaJuego/boton_abandonar.dart';

class PantallaJuego extends StatelessWidget {
  final mano = ["b0", "y4", "r8", "g7", "g9", "r3", "b2", "k%", "y5", "y4"];
  final mesa = ["b1", "y5", "r9", "g8", "g0", "r4", "r3"];
  final int turno = 3;

  PantallaJuego({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF515151),
      appBar: AppBar(
        toolbarHeight: 0,
      ),
      body: Container(
        decoration: 3 == turno
            ? BoxDecoration(
                border: Border.all(color: Colors.lime, width: 5),
                color: Color(0xFF515151),
              )
            : BoxDecoration(
                color: Color(0xFF515151),
              ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              color: Colors.blue,
              child: Row(
                children: [
                  Abandonar(),
                  Spacer(),
                  Text(
                    ' Es turno del jugador'.toUpperCase(),
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Spacer(),
                ],
              ),
            ),
            SizedBox(height: 10),
            // TODO: StreamBuilder jugadors
            StreamBuilder(
              stream: jugadorsSnapshots("5k9aj8mcVC6X5FOldq8o"),
              builder: (
                BuildContext context,
                AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot,
              ) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }
                final jugadorSnaps = snapshot.data!.docs;
                final jugadores = jugadorSnaps
                    .map(
                      (docSnap) =>
                          Jugador.fromFirestore(docSnap.id, docSnap.data()),
                    )
                    .toList();
                return barrajugador(jugadores: jugadores, turno: 0);
              },
            ),
            // TODO: StreamBuilder partida
            StreamBuilder(
              stream: partidaSnapshots("5k9aj8mcVC6X5FOldq8o"),
              builder: (
                BuildContext context,
                AsyncSnapshot<DocumentSnapshot<Partida>> snapshot,
              ) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }
                final doc = snapshot.data!;
                final data = doc.data();
                if (data == null) return Text("Null");

                return Text("${data.turno}");
              },
            ),
            Expanded(
              flex: 8,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(
                  children: [
                    Expanded(
                      child: CartaMesa(carta: mesa),
                    ),
                    Column(
                      children: [
                        Spacer(),
                        Uno(j1: Jugador("pepe")),
                        Spacer(),
                        Robar(j1: Jugador("pepe"), p1: Partida()),
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
                onPressed: (codigo) {
                  // TODO: Si soy el jugador que tira, actualizar turno y cartas
                  debugPrint(codigo);
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
