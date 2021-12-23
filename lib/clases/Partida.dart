// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:projecte_uno/clases/uno.dart';

import 'Jugador.dart';
import 'dart:math';

class Partida {
  late List<String> cartasMesa, cartasRobar;
  late bool enCurso;
  late int turno;

  Partida() {
    // Pasar Host
    cartasMesa = [];
    cartasRobar = [...barajaUno];
    cartasRobar.shuffle();
    enCurso = false;
    turno = 0;
  }

  Partida.fromFirestore(Map<String, dynamic> data)
      : cartasMesa = data['cartasMesa'],
        cartasRobar = data['cartasRobar'],
        enCurso = data['enCurso'],
        turno = data['turno'];

  Map<String, dynamic> toFirestore() => {
        'cartasMesa': cartasMesa,
        'cartasRobar': cartasRobar,
        'enCurso': enCurso,
        'turno': turno
      };
}

Stream<DocumentSnapshot<Partida>> partidaSnapshots(String id) {
  final db = FirebaseFirestore.instance;
  return db
      .doc("/Partidas/$id")
      .withConverter<Partida>(
        fromFirestore: (docSnap, _) => Partida.fromFirestore(docSnap.data()!),
        toFirestore: (Partida partida, _) => partida.toFirestore(),
      )
      .snapshots();
}

void addJugador(String idPartida, Jugador j) {
  final db = FirebaseFirestore.instance;
  //db.collection("/Partidas/$idPartida/Jugadores").add(j.toFirestore());
}


  // void eliminarJugador(int i) => jugadores.removeAt(i);

  // void addCartaMesa(String c) => cartasMesa.add(c);

//   String robar() {
//     return cartasRobar[0];
//     cartasRobar.removeAt(0);
//   }

//   void renovar() {
//     for (int i = cartasMesa.length - 1; i > 0; i--) {
//       cartasRobar.add(cartasMesa[i]);
//       cartasMesa.removeAt(i);
//     }
//     cartasRobar.shuffle();
//   }

//   void siguienteTurno() {
//     if (turno == jugadores.length - 1) {
//       turno = 0;
//     } else {
//       turno++;
//     }
//   }

//   void shuffleTurno() {
//     var rand = Random();
//     turno = rand.nextInt(jugadores.length);
//   }

//   void repartir() {
//     for (int i = 0; i < jugadores.length; i++) {
//       for (int j = 0; j < 7; j++) {
//         robar(i);
//       }
//     }
//   }
// }
