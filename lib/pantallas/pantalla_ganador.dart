import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:projecte_uno/clases/jugador.dart';
import 'package:projecte_uno/clases/partida.dart';

class PantallaGanador extends StatelessWidget {
  late String _nombre; // = 'Eustaquio';
  late bool _host; // = true;
  late String _id; // = "2WTVdNF7r9Uln6RDy4wT";

  PantallaGanador({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (ModalRoute.of(context) != null) {
      final infoJugador =
          ModalRoute.of(context)!.settings.arguments as List<dynamic>;
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

              final ganador = jugadores.where((j) => j.cartas.isEmpty).first;

              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        ganador.nombre == _nombre
                            ? "FELICIDADES"
                            : "FIN DE LA PARTIDA",
                        style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 20,
                            fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(height: 75),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[800],
                          borderRadius: BorderRadius.circular(48),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.pink,
                              spreadRadius: 20,
                              blurRadius: 20,
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(30, 48, 30, 48),
                          child: Row(
                            children: [
                              Image.network(
                                "https://webris.org/wp-content/uploads/2019/01/giphy.gif",
                                height: 75,
                                width: 75,
                              ),
                              Column(
                                children: [
                                  Icon(Icons.person,
                                      color: Colors.white.withAlpha(200),
                                      size: 100),
                                  Text(
                                    ganador.nombre == _nombre
                                        ? "¡Has Ganado!"
                                        : "¡${ganador.nombre} ha ganado!",
                                    style: const TextStyle(
                                        color: Colors.white70,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                              //Transform(
                              //transform: Matrix4.rotationY(3.1415),
                              Transform(
                                alignment: Alignment.center,
                                transform: Matrix4.rotationY(3.1415),
                                child: Image.network(
                                  "https://webris.org/wp-content/uploads/2019/01/giphy.gif",
                                  height: 75,
                                  width: 75,
                                ),
                              ),
                              //),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 75),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context, false);
                        },
                        child: const Padding(
                          padding: EdgeInsets.all(12),
                          child: Text(
                            "Ok",
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
