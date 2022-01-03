// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';

class Jugador {
  String? id;
  bool uno = false;
  int orden = -1;
  late String nombre;
  // late bool host; // TODO: treure aquest camp
  List<String> cartas = [];

  Jugador(this.nombre);

  Jugador.fromFirestore(String _id, Map<String, dynamic> data)
      : id = _id,
        nombre = data['nombre'],
        cartas = (data['cartas'] as List).cast<String>(),
        orden = data['orden'],
        uno = data['uno'];

  Map<String, dynamic> toFirestore() => {
        'nombre': nombre,
        'cartas': cartas,
        'orden': orden,
        'uno': uno,
      };

  Jugador.copia(Jugador j1)
      : id = j1.id,
        nombre = j1.nombre,
        uno = j1.uno,
        cartas = [...j1.cartas],
        orden = j1.orden;

  void addCarta(String cartaRobada) {
    cartas.add(cartaRobada);
  }
}

Stream<List<Jugador>> jugadorsSnapshots(String partidaId) {
  final db = FirebaseFirestore.instance;
  return db
      .collection("/Partidas/$partidaId/Jugadores")
      .snapshots()
      .map((querySnap) {
    final docs = querySnap.docs;
    List<Jugador> jugadors = [];
    for (final doc in docs) {
      jugadors.add(Jugador.fromFirestore(doc.id, doc.data()));
    }
    return jugadors;
  });
}

Future<void> addJugador(String idPartida, Jugador j) async {
  final db = FirebaseFirestore.instance;
  final doc = await db
      .collection("/Partidas/$idPartida/Jugadores")
      .add(j.toFirestore());
  j.id = doc.id;
}

//var j1 = Jugador("Juan", false);
//var j2 = Jugador.copia(j1);
