// ignore_for_file: file_names

import 'jugador.dart';
import 'dart:math';

class Partida {
  List<Jugador> jugadores = [];
  late List<String> cartasMesa, cartasRobar;
  late bool enCurso;
  late int turno;

  Partida(Jugador j) {
    //jugadores.add(j);
    cartasMesa = [];
    cartasRobar = [
      "b0",
      "b1",
      "b1",
      "b2",
      "b2",
      "b3",
      "b3",
      "b4",
      "b4",
      "b5",
      "b5",
      "b6",
      "b6",
      "b7",
      "b7",
      "b8",
      "b8",
      "b9",
      "b9",
      "y0",
      "y1",
      "y1",
      "y2",
      "y2",
      "y3",
      "y3",
      "y4",
      "y4",
      "y5",
      "y5",
      "y6",
      "y6",
      "y7",
      "y7",
      "y8",
      "y8",
      "y9",
      "y9",
      "g0",
      "g1",
      "g1",
      "g2",
      "g2",
      "g3",
      "g3",
      "g4",
      "g4",
      "g5",
      "g5",
      "g6",
      "g6",
      "g7",
      "g7",
      "g8",
      "g8",
      "g9",
      "g9",
      "r0",
      "r1",
      "r1",
      "r2",
      "r2",
      "r3",
      "r3",
      "r4",
      "r4",
      "r5",
      "r5",
      "r6",
      "r6",
      "r7",
      "r7",
      "r8",
      "r8",
      "r9",
      "r9",
      "b€",
      "b€",
      "g€",
      "g€",
      "r€",
      "r€",
      "y€",
      "y€",
      "b%",
      "b%",
      "g%",
      "g%",
      "r%",
      "r%",
      "y%",
      "y%",
      "b#",
      "b#",
      "g#",
      "g#",
      "r#",
      "r#",
      "y#",
      "y#",
      "k@",
      "k@",
      "k@",
      "k@",
      "k€",
      "k€",
      "k€",
      "k€"
    ];
    cartasRobar.shuffle();
    enCurso = false;
    turno = 0;
  }

  List<Jugador> getJugadores() => jugadores;

  List<String> getCartasMesa() => cartasMesa;

  List<String> getCartasRobar() => cartasRobar;

  bool getEnCurso() => enCurso;
  void setEnCurso(bool b) => enCurso = b;

  int getTurno() => turno;
  int setTurno(int i) => turno = i;

  //void addJugador(Jugador j) jugadores.add(j);
  //void eliminarJugador(int i) jugadores.removeAt(i);

  void addCartaMesa(String c) => cartasMesa.add(c);

  void robar(int i) {
    jugadores[i].addCarta(cartasRobar[0]);
    cartasRobar.removeAt(0);
  }

  void renovar() {
    for (int i = getCartasMesa().length - 1; i > 0; i--) {
      cartasRobar.add(cartasMesa[i]);
      cartasMesa.removeAt(i);
    }
    cartasRobar.shuffle();
  }

  void siguienteTurno() {
    if (turno == jugadores.length - 1) {
      turno = 0;
    } else {
      turno++;
    }
  }

  void shuffleTurno() {
    var rand = Random();
    turno = rand.nextInt(jugadores.length);
  }

  void repartir() {
    for (int i = 0; i < jugadores.length; i++) {
      for (int j = 0; j < 7; j++) {
        robar(i);
      }
    }
  }
}
