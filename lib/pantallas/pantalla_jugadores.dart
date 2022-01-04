// TODO: Hacer pantalla jugadores

import 'package:flutter/material.dart';
import 'package:projecte_uno/clases/Jugador.dart';
import 'package:projecte_uno/pantallas/pantallaJuego/juego.dart';

class PantallaJugadores extends StatefulWidget {
  const PantallaJugadores({Key? key}) : super(key: key);

  @override
  _PantallaJugadoresState createState() => _PantallaJugadoresState();
}

class _PantallaJugadoresState extends State<PantallaJugadores> {
  final List<Jugador> jugadores = [
    Jugador('jaime'),
    Jugador('pepe'),
    Jugador('felipe'),
    Jugador('oscar')
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF515151),
      appBar: AppBar(
        toolbarHeight: 0,
      ),
      body: Column(
        children: [
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
                      JugadorEnJuego(jugadores: jugadores, i: 0),
                      JugadorEnJuego(jugadores: jugadores, i: 1),
                      JugadorEnJuego(jugadores: jugadores, i: 2),
                      JugadorEnJuego(jugadores: jugadores, i: 3),
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
                child: const Text('       Codigo QR       '),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white54),
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
                      Navigator.of(context).pop();
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
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => PantallaJuego()));
                    },
                    splashColor: Colors.yellow,
                  )
                ],
              ))
        ],
      ),
    );
  }
}

class JugadorEnJuego extends StatelessWidget {
  const JugadorEnJuego({
    Key? key,
    required this.jugadores,
    required this.i,
  }) : super(key: key);

  final List<Jugador> jugadores;
  final int i;

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
            child: const Padding(
              padding: EdgeInsets.symmetric(vertical: 12, horizontal: 7),
              child: Text(
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
              ),
            ),
            color: Colors.green[700],
            onPressed: () {},
            splashColor: Colors.red[900],
          ),
        ],
      ),
    );
  }
}
