import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:projecte_uno/clases/baraja_uno.dart';

class Partida {
  late List<String> cartasMesa, cartasRobar;
  late bool enCurso;
  late int turno, sentido;
  late String color;

  Partida() {
    cartasMesa = [];
    cartasRobar = [...barajaUno];
    cartasRobar.shuffle();
    enCurso = false;
    turno = 0;
    sentido = 1;
    color = '';
  }

  Partida.fromFirestore(Map<String, dynamic> data)
      : cartasMesa = (data['cartasMesa'] as List).cast<String>(),
        cartasRobar = (data['cartasRobar'] as List).cast<String>(),
        enCurso = data['enCurso'],
        turno = data['turno'],
        sentido = data['sentido'],
        color = data['color'];

  Map<String, dynamic> toFirestore() => {
        'cartasMesa': cartasMesa,
        'cartasRobar': cartasRobar,
        'enCurso': enCurso,
        'turno': turno,
        'sentido': sentido,
        'color': color,
      };

  void cambioSentido() {
    sentido = -sentido;
  }

  String robar() {
    final c = cartasRobar[0];
    cartasRobar.removeAt(0);
    return c;
  }
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


  // void eliminarJugador(int i) => jugadores.removeAt(i);

  // void addCartaMesa(String c) => cartasMesa.add(c);

//   void repartir() {
//     for (int i = 0; i < jugadores.length; i++) {
//       for (int j = 0; j < 7; j++) {
//         robar(i);
//       }
//     }
//   }
// }
