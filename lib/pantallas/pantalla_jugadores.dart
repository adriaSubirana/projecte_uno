import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:projecte_uno/clases/jugador.dart';
import 'package:projecte_uno/pantallas/pantallaJuego/juego.dart';
import 'package:qr_flutter/qr_flutter.dart';

class PantallaJugadores extends StatefulWidget {
  const PantallaJugadores({Key? key}) : super(key: key);

  @override
  _PantallaJugadoresState createState() => _PantallaJugadoresState();
}

//Texto conflict
class _PantallaJugadoresState extends State<PantallaJugadores> {
  late final List<dynamic> _infoJugador;
  late String idjugador;

  @override
  Widget build(BuildContext context) {
    if (ModalRoute.of(context) != null) {
      _infoJugador =
          ModalRoute.of(context)!.settings.arguments as List<dynamic>;
    }
    return Scaffold(
      backgroundColor: const Color(0xFF515151),
      appBar: AppBar(
        toolbarHeight: 0,
      ),
      body: StreamBuilder(
        stream: jugadorsSnapshots(_infoJugador[1]),
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
                (docSnap) => Jugador.fromFirestore(docSnap.id, docSnap.data()),
              )
              .toList();

          bool e = false;
          for (final j in jugadores) {
            if (j.nombre == _infoJugador[0]) e = true;
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
                        "El jugador \"${_infoJugador[0]}\" no existe o te han echado.\n\nVuelve a la pantalla inicial.",
                        style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 18,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
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

          return Column(children: [
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(30, 15, 60, 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Lista de Jugadores',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.white),
                    ),
                    Image.network(
                        "https://upload.wikimedia.org/wikipedia/commons/thumb/f/f9/UNO_Logo.svg/825px-UNO_Logo.svg.png"),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 6,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(35, 5, 35, 0),
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.white54),
                      color: Colors.grey.withAlpha(50)),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10, bottom: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        for (int i = 0; i < jugadores.length; i++)
                          JugadorEnJuego(
                            jugadores: jugadores,
                            i: i,
                            hostEspera: _infoJugador[2],
                            idpartida: _infoJugador[1],
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 6,
              child: Center(
                child: Container(
                  child: Center(
                    child: QrImage(
                      data: _infoJugador[1],
                      version: QrVersions.auto,
                      size: 220,
                    ),
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: _infoJugador[2] ? Colors.red : Colors.blue),
                  ),
                ),
              ),
            ),
            Expanded(
                flex: 4,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    MaterialButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                      child: const Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 12, horizontal: 7),
                        child: Text(
                          'Abandonar',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            shadows: [
                              Shadow(
                                color: Colors.black,
                                offset: Offset(0, 3),
                                blurRadius: 2,
                              )
                            ],
                          ),
                        ),
                      ),
                      color: Colors.red.withAlpha(100),
                      onPressed: () {
                        showDialog<bool>(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                backgroundColor: const Color(0xFF515151),
                                title: const Text(
                                  "Abandonar",
                                  style: TextStyle(color: Colors.white70),
                                ),
                                content: const Text(
                                    "Seguro que quieres abandonar la partida?"),
                                actions: [
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.pop(context, false),
                                    child: const Text("Cancelar"),
                                  ),
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.pop(context, true),
                                    child: const Text("Abandonar"),
                                  ),
                                ],
                              );
                            }).then((value) {
                          if (value != null && value) {
                            Navigator.of(context).pop(true);
                          }
                        });
                        //merge conflict
                      },
                      splashColor: Colors.yellow,
                    ),
                    MaterialButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                      child: const Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 12, horizontal: 7),
                        child: Text(
                          'Comenzar',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              shadows: [
                                Shadow(
                                  color: Colors.black,
                                  offset: Offset(0, 3),
                                  blurRadius: 2,
                                )
                              ],
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      color: Colors.red[900],
                      onPressed: () {
                        for (final j in jugadores) {
                          if (j.nombre == _infoJugador[0] &&
                              _infoJugador[2] == true) {
                            // partida.enCurso = true;
                            for (int i = 0; i < jugadores.length; i++) {
                              jugadores[i].orden = i;
                              for (int j = 0; j < 7; j++) {
                                //   jugadores[i].addCarta(partida.robar());
                              }
                            }
                          }
                        }

                        //if (partida.enCurso == true) {
                        Navigator.of(context)
                            .pushNamed('/juego', arguments: _infoJugador)
                            .then((value) {
                          if (value == true) {
                            Navigator.of(context)
                                .pushNamed('/ganador', arguments: _infoJugador);
                          } else {
                            Navigator.pop(context);
                          }
                        });
                      },
                      // },
                      splashColor: Colors.yellow,
                    )
                  ],
                ))
          ]);
        },
      ),
    );
  }
}

class JugadorEnJuego extends StatelessWidget {
  const JugadorEnJuego({
    Key? key,
    required this.jugadores,
    required this.i,
    required this.hostEspera,
    required this.idpartida,
  }) : super(key: key);

  final List<Jugador> jugadores;
  final int i;
  final bool hostEspera;
  final String idpartida;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            jugadores[i].nombre.toUpperCase(),
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          MaterialButton(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 7),
              child: hostEspera == false
                  ? const Text(
                      'Eliminar ',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          shadows: [
                            Shadow(
                              color: Colors.black,
                              offset: Offset(0, 3),
                              blurRadius: 2,
                            )
                          ],
                          fontWeight: FontWeight.bold),
                    )
                  : null,
            ),
            color: Colors.green[700],
            onPressed: hostEspera == true
                ? () {
                    showDialog<bool>(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text("Eliminar"),
                            content: const Text(
                                "Seguro que deseas eliminar al jugador ?"),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context, false),
                                child: const Text("Cancelar"),
                              ),
                              TextButton(
                                onPressed: () {
                                  FirebaseFirestore.instance
                                      .doc(
                                          "/Partidas/$idpartida/Jugadores/${jugadores[i].id}")
                                      .delete();
                                  Navigator.pop(context, true);
                                },
                                child: const Text("Eliminar jugador"),
                              ),
                            ],
                          );
                        });
                  }
                : null,
            splashColor: Colors.red[900],
          ),
        ],
      ),
    );
  }
}
