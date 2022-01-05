// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:projecte_uno/clases/jugador.dart';
import 'package:projecte_uno/clases/partida.dart';
import 'package:projecte_uno/pantallas/pantallaJuego/cartas_mesa.dart';
import 'package:projecte_uno/pantallas/pantallaJuego/cartas_mano.dart';
import 'package:projecte_uno/pantallas/pantallaJuego/robar.dart';
import 'package:projecte_uno/pantallas/pantallaJuego/uno.dart';
import 'package:projecte_uno/pantallas/pantallaJuego/barra_jugadores.dart';
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
          final collection =
              FirebaseFirestore.instance.collection("/Partida").doc(_id);
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
                    Stack(
                      children: [
                        Align(
                          child: Abandonar(
                            host: _host,
                            salir: () {
                              if (_host) {
                                collection.delete();
                              } else {
                                // TODO: Pasar totes les cartes del jugador a cartasRobar
                                FirebaseFirestore.instance
                                    .collection("/Partidas/$_id/Jugadores")
                                    .doc(yo.id)
                                    .delete();
                              }
                              Navigator.pop(context);
                            },
                            then: () {
                              // TODO: si abandones retorna false i ha de tornar a /login però si s'acaba la partida torna a /espera
                              Navigator.pop(context, false);
                            },
                          ),
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
                              style: TextStyle(
                                color: Colors.white70,
                                fontWeight: FontWeight.w600,
                              ),
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
                                Robar(
                                  partida: partida,
                                  onPressed: partida.turno % jugadores.length ==
                                          yo.orden
                                      ? () {
                                          // TODO: Actualizar turno y cartas
                                          partida.turno++;
                                          collection
                                              .update({'turno': 4})
                                              .then((value) =>
                                                  debugPrint("turno updated"))
                                              .catchError((error) => debugPrint(
                                                  "Failed to update turno: $error"));
                                        }
                                      : null,
                                ),
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
                        child: CartasMano(
                          cartas: mano,
                          onPressed: (codigo) {
                            partida.turno % jugadores.length == yo.orden
                                ?
                                // TODO: Actualizar turno y cartas
                                debugPrint(codigo)
                                : null;
                          },
                        ),
                      ),
                    ),
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
