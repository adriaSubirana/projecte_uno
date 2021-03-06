import 'package:cloud_firestore/cloud_firestore.dart';

class Jugador {
  String? id;
  bool uno = false;
  int orden = -1;
  late String nombre;
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

Stream<QuerySnapshot<Map<String, dynamic>>> jugadorsSnapshots(
    String partidaId) {
  final db = FirebaseFirestore.instance;
  return db
      .collection("/Partidas/$partidaId/Jugadores")
      .orderBy('orden')
      .snapshots();
}

Future<void> addJugador(String idPartida, Jugador j) async {
  final db = FirebaseFirestore.instance;
  final doc = await db
      .collection("/Partidas/$idPartida/Jugadores")
      .add(j.toFirestore());
  j.id = doc.id;
}

Future<void> ultimaCarta(String idPartida, Jugador jtarget, Jugador jactual) {
  final db = FirebaseFirestore.instance;
  return db.runTransaction(
    (transaction) async {
      final jugadorRef = db.doc("/Partidas/$idPartida/Jugadores/${jtarget.id}");
      final docSnap = await transaction.get(jugadorRef);
      final data = docSnap.data()!;
      if (!(data['uno'] as bool)) {
        transaction.update(jugadorRef, {'uno': true});
        // Yo sé que he escrit el valor
        // TODO: Mirar si el jugador és el mateix i fer multa o no.
      }
    },
  );
}
