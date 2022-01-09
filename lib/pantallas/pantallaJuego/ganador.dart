import 'package:flutter/material.dart';
import 'package:projecte_uno/clases/jugador.dart';

class Ganador extends StatelessWidget {
  late var infoJugador;
  late Jugador ganador;
  Ganador({Key? key, required this.infoJugador, required this.ganador})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              ganador.nombre == infoJugador[0]
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
                            color: Colors.white.withAlpha(200), size: 100),
                        Text(
                          ganador.nombre == infoJugador[0]
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
  }
}
