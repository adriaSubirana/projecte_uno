import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:projecte_uno/clases/jugador.dart';
import 'package:projecte_uno/clases/partida.dart';
import 'package:projecte_uno/pantallas/pantallaJuego/carta.dart';
import 'package:projecte_uno/pantallas/pantallaJuego/cartas_mesa.dart';
import 'package:projecte_uno/pantallas/pantallaJuego/cartas_mano.dart';
import 'package:projecte_uno/pantallas/pantallaJuego/ganador.dart';
import 'package:projecte_uno/pantallas/pantallaJuego/robar.dart';
import 'package:projecte_uno/pantallas/pantallaJuego/uno.dart';
import 'package:projecte_uno/pantallas/pantallaJuego/barra_jugadores.dart';
import 'package:projecte_uno/pantallas/pantallaJuego/boton_abandonar.dart';

// ignore: must_be_immutable
class PantallaJuego extends StatelessWidget {
  late List infoJugador;
  late String _nombre; // = 'Eustaquio';
  late bool _host; // = true;
  late String _id; // = "2WTVdNF7r9Uln6RDy4wT";

  PantallaJuego({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (ModalRoute.of(context) != null) {
      infoJugador = ModalRoute.of(context)!.settings.arguments as List<dynamic>;
      _nombre = infoJugador[0];
      _id = infoJugador[1];
      _host = infoJugador[2];
    }
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
          if (partida == null) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text(
                      "Error",
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 32,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 24),
                      child: Text(
                        "La partida \"$_id\" no existe o se ha borrado.\n\nVuelve a la pantalla inicial.",
                        style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 18,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context, false);
                      },
                      child: const Text(
                        "Volver",
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }

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

          if (partida.cartasMesa.isNotEmpty) {
            if (partida.cartasMesa.last[0] != 'k') {
              partida.color = "";
              docPartida.update(partida.toFirestore());
            }
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

              if (jugadores.isEmpty) {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const Text(
                          "Error",
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 32,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 24),
                          child: Text(
                            "No hay jugadores.\n\nVuelve a la pantalla inicial.",
                            style: TextStyle(
                                color: Colors.white70,
                                fontSize: 18,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context, false);
                          },
                          child: const Text(
                            "Volver",
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }
              // Error si tu nombre no coincide
              bool e = false;
              for (final j in jugadores) {
                if (j.nombre == _nombre) e = true;
              }
              if (!e) {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const Text(
                          "Error",
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 32,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 24),
                          child: Text(
                            "El jugador \"$_nombre\" no existe.\n\nVuelve a la pantalla inicial.",
                            style: const TextStyle(
                                color: Colors.white70,
                                fontSize: 18,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context, false);
                          },
                          child: const Text(
                            "Volver",
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }

              final yo = jugadores.where((j) => j.nombre == _nombre).first;
              final otros = jugadores.where((j) => j.nombre != _nombre);
              final collectionJugadores = FirebaseFirestore.instance
                  .collection("/Partidas/$_id/Jugadores");

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

              if (!partida.enCurso) {
                final ganador = jugadores.where((j) => j.cartas.isEmpty).first;
                return Ganador(infoJugador: infoJugador, ganador: ganador);
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
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(0, 20, 15, 0),
                            child: Text(
                              'Posicion: ${yo.orden + 1}',
                              style: const TextStyle(color: Colors.white70),
                            ),
                          ),
                          alignment: Alignment.topRight,
                        ),
                        Align(
                          child: Abandonar(
                            host: _host,
                            salir: () {
                              if (_host) {
                                docPartida.delete();
                              } else {
                                // Si abandona no host,
                                // pasar totes les cartes del jugador a cartasRobar
                                for (final c in yo.cartas) {
                                  partida.cartasRobar.add(c);
                                }
                                partida.cartasRobar.shuffle();
                                docPartida.update(partida.toFirestore());
                                collectionJugadores.doc(yo.id).delete();
                              }
                              Navigator.pop(context, true);
                            },
                            then: (value) {
                              // Ai abandonas retorna false i tiene que volver hasta /login
                              // pero si se acaba la partida retorna true y vuelve a /espera
                              if (value) Navigator.pop(context, false);
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
                    BarraJugadores(
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
                                child: CartaMesa(cartas: partida.cartasMesa),
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
                          onPressed: (codigo) async {
                            if (partida.turno % jugadores.length == yo.orden) {
                              if (codigo[0] == partida.cartasMesa.last[0] ||
                                  codigo[1] == partida.cartasMesa.last[1] ||
                                  codigo[0] == 'k' ||
                                  codigo[0] == partida.color) {
                                partida.cartasMesa.add(codigo);
                                yo.cartas.remove(codigo);

                                if (codigo[1] == '%') {
                                  if (jugadores.length == 2) {
                                    partida.turno =
                                        partida.turno + partida.sentido;
                                  }
                                  partida.cambioSentido();
                                }
                                if (codigo[1] == '#') {
                                  partida.turno =
                                      partida.turno + partida.sentido;
                                }
                                if (codigo[0] == 'k') {
                                  if (codigo[1] == '€') {
                                    // Si quedan 4 cartas o menos se renuevan
                                    if (partida.cartasRobar.length <= 4) {
                                      for (int i =
                                              partida.cartasMesa.length - 2;
                                          i >= 0;
                                          i--) {
                                        partida.cartasRobar
                                            .add(partida.cartasMesa[i]);
                                      }
                                      partida.cartasMesa.removeRange(
                                          0, partida.cartasMesa.length - 1);
                                      partida.cartasRobar.shuffle();
                                    }
                                    partida.turno =
                                        partida.turno + partida.sentido;
                                    for (int i = 0; i < 4; i++) {
                                      jugadores[
                                              partida.turno % jugadores.length]
                                          .addCarta(partida.robar());
                                    }
                                    collectionJugadores
                                        .doc(jugadores[partida.turno %
                                                jugadores.length]
                                            .id)
                                        .update(jugadores[partida.turno %
                                                jugadores.length]
                                            .toFirestore());
                                    const snackBar = SnackBar(
                                      content: Text("Chupas 4 cartas"),
                                    );
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(snackBar);
                                  }
                                  // Show dialog para escoger color
                                  await showDialog<String>(
                                    context: context,
                                    builder: (context) {
                                      return Center(
                                        child: SimpleDialog(
                                          backgroundColor:
                                              const Color(0xFF515151),
                                          title: const Text(
                                            "Escoge color",
                                            style: TextStyle(
                                              color: Colors.white70,
                                            ),
                                          ),
                                          children: [
                                            Column(
                                              children: [
                                                Row(
                                                  children: [
                                                    SimpleDialogOption(
                                                      onPressed: () {
                                                        Navigator.pop(
                                                            context, 'r');
                                                      },
                                                      child: const Card(
                                                        color: Colors.red,
                                                        child: SizedBox(
                                                          height: 80,
                                                          width: 80,
                                                        ),
                                                      ),
                                                    ),
                                                    SimpleDialogOption(
                                                      onPressed: () {
                                                        Navigator.pop(
                                                            context, 'b');
                                                      },
                                                      child: const Card(
                                                        color: Colors.blue,
                                                        child: SizedBox(
                                                          height: 80,
                                                          width: 80,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    SimpleDialogOption(
                                                      onPressed: () {
                                                        Navigator.pop(
                                                            context, 'y');
                                                      },
                                                      child: const Card(
                                                        color: Colors.amber,
                                                        child: SizedBox(
                                                          height: 80,
                                                          width: 80,
                                                        ),
                                                      ),
                                                    ),
                                                    SimpleDialogOption(
                                                      onPressed: () {
                                                        Navigator.pop(
                                                            context, 'g');
                                                      },
                                                      child: const Card(
                                                        color: Colors.green,
                                                        child: SizedBox(
                                                          height: 80,
                                                          width: 80,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  ).then(
                                    (value) {
                                      if (value == null) {
                                        switch (Random().nextInt(3)) {
                                          case 0:
                                            partida.color = 'r';
                                            break;
                                          case 1:
                                            partida.color = 'b';
                                            break;
                                          case 2:
                                            partida.color = 'y';
                                            break;
                                          case 3:
                                            partida.color = 'g';
                                            break;
                                        }
                                      } else {
                                        partida.color = value;
                                      }
                                    },
                                  );
                                } else {
                                  if (codigo[1] == '€') {
                                    // Si quedan 2 cartas o menos se renuevan
                                    if (partida.cartasRobar.length <= 2) {
                                      for (int i =
                                              partida.cartasMesa.length - 2;
                                          i >= 0;
                                          i--) {
                                        partida.cartasRobar
                                            .add(partida.cartasMesa[i]);
                                      }
                                      partida.cartasMesa.removeRange(
                                          0, partida.cartasMesa.length - 1);
                                      partida.cartasRobar.shuffle();
                                    }
                                    partida.turno =
                                        partida.turno + partida.sentido;
                                    for (int i = 0; i < 2; i++) {
                                      jugadores[
                                              partida.turno % jugadores.length]
                                          .addCarta(partida.robar());
                                    }
                                    collectionJugadores
                                        .doc(jugadores[partida.turno %
                                                jugadores.length]
                                            .id)
                                        .update(jugadores[partida.turno %
                                                jugadores.length]
                                            .toFirestore());
                                    const snackBar = SnackBar(
                                      content: Text("Chupas 2 cartas"),
                                    );
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(snackBar);
                                  }
                                }

                                partida.turno = partida.turno + partida.sentido;
                                collectionJugadores
                                    .doc(yo.id)
                                    .update(yo.toFirestore());
                                // Cuando te quedas sin cartas has ganado y la partida acaba
                                if (yo.cartas.isEmpty) {
                                  partida.enCurso = false;
                                }
                                docPartida.update(partida.toFirestore());
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
