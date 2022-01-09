import 'package:flutter/material.dart';
import 'package:projecte_uno/clases/jugador.dart';

// TODO: poner orden en cara jugadores
class BarraJugadores extends StatelessWidget {
  final Iterable<Jugador> jugadores;
  final int turno;
  const BarraJugadores({
    Key? key,
    required this.jugadores,
    required this.turno,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (final j in jugadores)
            Container(
              //width: 55,
              //height: 75,
              child: ShowUser(numcartas: j.cartas.length, nombre: j.nombre),
              decoration: j.orden == turno
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
    );
  }
}

class ShowUser extends StatelessWidget {
  final int numcartas;
  final String nombre;
  const ShowUser({
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
              padding: const EdgeInsets.fromLTRB(2, 4, 2, 0),
              child: Icon(Icons.person,
                  color: Colors.white.withAlpha(200), size: 55),
            ),
            Container(
              width: 55,
              height: 55,
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 4, 2, 0),
                child: Container(
                  width: 15,
                  height: 15,
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle, color: Colors.red),
                  child: Center(
                    child: Text(
                      "$numcartas",
                      style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 12),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(4, 0, 4, 2),
          child: Text(
            nombre,
            style: TextStyle(
              color: Colors.white.withAlpha(200),
              fontSize: 11,
            ),
          ),
        ),
      ],
    );
  }
}
