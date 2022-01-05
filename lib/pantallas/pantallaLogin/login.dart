import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:projecte_uno/clases/jugador.dart';
import 'package:projecte_uno/clases/partida.dart';
import 'package:projecte_uno/pantallas/pantalla_jugadores.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  late TextEditingController controller;
  late bool _crear;
  late bool _unirse;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController(
      text: "",
    );
    _crear = false;
    _unirse = false;
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Future<void> _crearPulsado() async {
    debugPrint(controller.text + " host");
    setState(() {
      _crear = !_crear;
    });
    final p = Partida();
    final j = Jugador(controller.text);
    final docSnap = await FirebaseFirestore.instance
        .collection('/Partidas')
        .add(p.toFirestore());
    addJugador(docSnap.id, j);
    Navigator.of(context)
        .pushNamed('/espera', arguments: docSnap.id)
        .then((value) {
      if (value != null && value == true) {
        FirebaseFirestore.instance
            .collection('/Partidas')
            .doc(docSnap.id)
            .delete();
      }
    });
  }

  void _unirsePulsado() {
    debugPrint(controller.text + " no host");
    setState(() {
      _unirse = !_unirse;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF515151),
      appBar: AppBar(
        toolbarHeight: 0,
      ),
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: SizedBox(
          height: MediaQuery.of(context).size.height -
              AppBar().preferredSize.height,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.network(
                      "https://upload.wikimedia.org/wikipedia/commons/thumb/f/f9/UNO_Logo.svg/825px-UNO_Logo.svg.png"),
                  const SizedBox(height: 64),
                  const Text(
                    "Nickname",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),
                  TextField(
                    controller: controller,
                    textCapitalization: TextCapitalization.words,
                    style: const TextStyle(color: Colors.white),
                    maxLength: 15,
                    decoration: const InputDecoration(
                      hintText: "Introduce tu nombre",
                      hintStyle: TextStyle(color: Colors.white60),
                      counterStyle: TextStyle(color: Colors.white70),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      contentPadding: EdgeInsets.symmetric(horizontal: 8),
                    ),
                  ),
                  const SizedBox(height: 32),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          // TODO: Soy el host, llamar a PantallaJugadores con host = true, nombre
                          _crearPulsado();
                          Navigator.of(context).pushNamed('/espera');
                        },
                        child: const Text(
                          "Crear",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              shadows: [
                                Shadow(
                                  color: Colors.black,
                                  offset: Offset(-1, 2),
                                  blurRadius: 2,
                                )
                              ],
                              fontWeight: FontWeight.bold),
                        ),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.red[900],
                          padding: const EdgeInsets.symmetric(
                              vertical: 12, horizontal: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 12,
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          // TODO: No soy el host, llamar a PantallaJugadores con host = false, nombre
                          _unirsePulsado();
                        },
                        child: const Text(
                          "Unirse",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              shadows: [
                                Shadow(
                                  color: Colors.black,
                                  offset: Offset(-1, 2),
                                  blurRadius: 2,
                                )
                              ],
                              fontWeight: FontWeight.bold),
                        ),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.red[900],
                          padding: const EdgeInsets.symmetric(
                              vertical: 12, horizontal: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
