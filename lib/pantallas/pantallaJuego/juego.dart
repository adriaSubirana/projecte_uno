// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:projecte_uno/clases/Jugador.dart';
import 'package:projecte_uno/clases/Partida.dart';
import 'package:projecte_uno/pantallas/pantallaJuego/CartasMesa.dart';
import 'package:projecte_uno/pantallas/pantallaJuego/CartasMano.dart';
import 'package:projecte_uno/pantallas/pantallaJuego/Robar.dart';
import 'package:projecte_uno/pantallas/pantallaJuego/uno.dart';
import 'package:projecte_uno/pantallas/pantallaJuego/barrajugadores.dart';
import 'package:projecte_uno/pantallas/pantallaJuego/boton_abandonar.dart';

class PantallaJuego extends StatelessWidget {
  final _nombre = 'Eustaquio';
  final _host = true;
  final _id = "5k9aj8mcVC6X5FOldq8o";

  const PantallaJuego({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF515151),
      appBar: AppBar(
        toolbarHeight: 0,
      ),
      body: StreamBuilder(
        stream: partidaSnapshots(_id),
        builder: (
          BuildContext context,
          AsyncSnapshot<DocumentSnapshot<Partida>> snapshot,
        ) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          final doc = snapshot.data!;
          final partida = doc.data();
          if (partida == null) return Text("Esta partida no existe");
          return StreamBuilder(
            stream: jugadorsSnapshots(_id),
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
              jugadores.sort((a, b) => a.orden.compareTo(b.orden));
              final yo = jugadores.where((j) => j.nombre == _nombre).first;
              final mano = yo.cartas;
              final otros = jugadores.where((j) => j.nombre != _nombre);

              return Container(
                decoration: partida.turno % jugadores.length == yo.orden
                    ? BoxDecoration(
                        boxShadow: [
                          const BoxShadow(
                            color: Colors.yellow,
                          ),
                          const BoxShadow(
                            color: Color(0xFF515151),
                            spreadRadius: -6,
                            blurRadius: 6,
                          ),
                        ],
                      )
                    : null,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    /*Align(
                      child: Abandonar(),
                      alignment: Alignment.topLeft,
                    ),*/
                    Stack(
                      children: [
                        Align(
                          child: Abandonar(),
                          alignment: Alignment.topLeft,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              partida.turno % jugadores.length == yo.orden
                                  ? "Tu turno"
                                  : "Turno de ${jugadores.where((j) => j.orden == partida.turno % jugadores.length).first.nombre}",
                              style: TextStyle(color: Colors.white70),
                            ),
                          ),
                        ),
                      ],
                    ),
                    barrajugador(
                        jugadores: otros,
                        turno: partida.turno % jugadores.length),
                    Expanded(
                      flex: 8,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        child: Row(
                          children: [
                            Expanded(
                              child: CartaMesa(carta: partida.cartasMesa),
                            ),
                            Column(
                              children: [
                                Spacer(),
                                Uno(j1: yo),
                                Spacer(),
                                Robar(j1: yo, p1: partida),
                                Spacer(),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Center(
                        /*child: Container(
                          decoration:
                              partida.turno % jugadores.length == yo.orden
                                  ? BoxDecoration(
                                      boxShadow: const [
                                        BoxShadow(
                                          color: Colors.lime,
                                          spreadRadius: 7,
                                          blurRadius: 7,
                                        ),
                                      ],
                                    )
                                  : null,*/
                        child: CartasMano(
                          cartas: mano,
                          onPressed: (codigo) {
                            // TODO: Si soy el jugador que tira, actualizar turno y cartas
                            debugPrint(codigo);
                          },
                        ),
                      ),
                    ),
                    //)
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
