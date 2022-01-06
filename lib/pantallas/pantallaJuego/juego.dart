import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:projecte_uno/clases/jugador.dart';
import 'package:projecte_uno/clases/partida.dart';
import 'package:projecte_uno/pantallas/pantallaJuego/carta.dart';
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
          if (partida == null) return const Text("Esta partida no existe");

          // Si només queda una carta en cartasRobar,
          // host posa les de cartasMesa a cartasRobar menys la ultima i shuffle
          if (partida.cartasRobar.length <= 1 && _host) {
            for (int i = partida.cartasMesa.length - 2; i >= 0; i--) {
              partida.cartasRobar.add(partida.cartasMesa[i]);
            }
            partida.cartasMesa.removeRange(0, partida.cartasMesa.length - 1);
            partida.cartasRobar.shuffle();
            docPartida.update(partida.toFirestore());
          }

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

              if (jugadores.isEmpty) return const Text("No hay jugadores");
              final yo = jugadores.where((j) => j.nombre == _nombre).first;
              final otros = jugadores.where((j) => j.nombre != _nombre);
              final collectionJugadores = FirebaseFirestore.instance
                  .collection("/Partidas/$_id/Jugadores");

              // Si tiene que tomar alguna: toma, pone tomar a 0 y pasa turno
              if (partida.tomar != 0) {
                for (int i = 0; i < partida.tomar; i++) {
                  yo.addCarta(partida.robar());
                }
                collectionJugadores.doc(yo.id).update(yo.toFirestore());
                partida.tomar = 0;
                partida.turno = partida.turno + partida.sentido;
                docPartida.update(partida.toFirestore());
              }

              // El host cambia orden de cada jugador si alguien se va
              var b = false;
              for (final j in jugadores) {
                if (j.orden >= jugadores.length) b = true;
              }
              if (b && _host) {
                jugadores.shuffle();
                var i = 0;
                for (final j in jugadores) {
                  j.orden = i;
                  i++;
                  collectionJugadores.doc(j.id).update(j.toFirestore());
                }
              }

              return Container(
                decoration: partida.turno % jugadores.length == yo.orden
                    ? const BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.yellow,
                          ),
                          BoxShadow(
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
                                // Si abandona no host,
                                // pasar totes les cartes del jugador a cartasRobar i
                                for (final c in yo.cartas) {
                                  partida.cartasRobar.add(c);
                                }
                                partida.cartasRobar.shuffle();
                                docPartida.update(partida.toFirestore());
                                collectionJugadores.doc(yo.id).delete();
                              }
                              Navigator.pop(context);
                            },
                            then: () {
                              // TODO: si abandonas retorna false i tiene que volver hasta /login
                              // pero si se acaba la partida retorna true y vuelve a /espera
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
                              style: const TextStyle(
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
                              child: Container(
                                decoration: partida.color == ""
                                    ? null
                                    : BoxDecoration(
                                        borderRadius: BorderRadius.circular(32),
                                        boxShadow: [
                                          BoxShadow(
                                            color: cardColor[partida.color]!,
                                            spreadRadius: 8,
                                            blurRadius: 8,
                                          )
                                        ],
                                      ),
                                child: CartaMesa(carta: partida.cartasMesa),
                              ),
                            ),
                            Column(
                              children: [
                                const Spacer(),
                                Uno(j1: yo),
                                const Spacer(),
                                Robar(
                                  partida: partida,
                                  onPressed: partida.turno % jugadores.length ==
                                          yo.orden
                                      ? () {
                                          yo.addCarta(partida.robar());
                                          collectionJugadores
                                              .doc(yo.id)
                                              .update(yo.toFirestore());
                                          partida.turno =
                                              partida.turno + partida.sentido;
                                          docPartida
                                              .update(partida.toFirestore());
                                        }
                                      : null,
                                ),
                                const Spacer(),
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
                              if (codigo[0] == partida.cartasMesa.last[0] ||
                                  codigo[1] == partida.cartasMesa.last[1] ||
                                  codigo[0] == 'k' ||
                                  codigo[0] == partida.color) {
                                if (codigo[1] == '%') partida.cambioSentido();
                                if (codigo[1] == '#') {
                                  partida.turno =
                                      partida.turno + partida.sentido;
                                }
                                if (codigo[0] == 'k') {
                                  if (codigo[1] == '€') partida.tomar = 4;
                                  // TODO: Show dialog para escoger color
                                  docPartida.update(partida.toFirestore());
                                } else if (codigo[1] == '€') {
                                  partida.tomar = 2;
                                  docPartida.update(partida.toFirestore());
                                }

                                partida.cartasMesa.add(codigo);
                                partida.turno = partida.turno + partida.sentido;
                                docPartida.update(partida.toFirestore());
                                yo.cartas.remove(codigo);
                                collectionJugadores
                                    .doc(yo.id)
                                    .update(yo.toFirestore());
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
