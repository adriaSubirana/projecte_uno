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
          final docPartida =
              FirebaseFirestore.instance.collection("/Partidas").doc(_id);
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

              if (jugadores.isEmpty) return Text("No hay jugadores");
              final yo = jugadores.where((j) => j.nombre == _nombre).first;
              final otros = jugadores.where((j) => j.nombre != _nombre);
              final collectionJugadores = FirebaseFirestore.instance
                  .collection("/Partidas/$_id/Jugadores");

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
                                docPartida.delete();
                              } else {
                                // TODO: Pasar totes les cartes del jugador a cartasRobar
                                collectionJugadores.doc(yo.id).delete();
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
                                          yo.addCarta(
                                              partida.cartasRobar.first);
                                          collectionJugadores
                                              .doc(yo.id)
                                              .update(yo.toFirestore())
                                              .then((value) =>
                                                  debugPrint("yo updated"))
                                              .catchError((error) => debugPrint(
                                                  "Failed to update yo: $error"));
                                          partida.cartasRobar.removeAt(0);
                                          partida.turno =
                                              partida.turno + partida.sentido;
                                          docPartida
                                              .update(partida.toFirestore())
                                              .then((value) =>
                                                  debugPrint("Partida updated"))
                                              .catchError((error) => debugPrint(
                                                  "Failed to update partida: $error"));
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
                          cartas: yo.cartas,
                          onPressed: (codigo) {
                            if (partida.turno % jugadores.length == yo.orden) {
                              // TODO: Actualizar turno y cartas
                              if (codigo[0] == partida.cartasMesa.last[0] ||
                                  codigo[1] == partida.cartasMesa.last[1]) {
                                if (codigo[1] == '%') partida.cambioSentido();
                                if (codigo[1] == '#') {
                                  partida.turno =
                                      partida.turno + partida.sentido;
                                }
                                partida.cartasMesa.add(codigo);
                                partida.turno = partida.turno + partida.sentido;
                                docPartida
                                    .update(partida.toFirestore())
                                    .then((value) =>
                                        debugPrint("Partida updated"))
                                    .catchError((error) => debugPrint(
                                        "Failed to update partida: $error"));
                                yo.cartas.remove(codigo);
                                collectionJugadores
                                    .doc(yo.id)
                                    .update(yo.toFirestore())
                                    .then((value) => debugPrint("yo updated"))
                                    .catchError((error) => debugPrint(
                                        "Failed to update yo: $error"));
                                debugPrint(codigo);
                              }
                            } else {
                              null;
                            }
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
