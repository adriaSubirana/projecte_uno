import 'package:flutter/material.dart';

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

  void _crearPulsado() {
    setState(() {
      _crear = !_crear;
    });
  }

  void _unirsePulsado() {
    setState(() {
      _unirse = !_unirse;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black.withAlpha(170),
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
                  // TODO: Cambiar por ElevatedButton
                  FloatingActionButton.extended(
                    splashColor: Colors.yellow,
                    onPressed: () {
                      // TODO: Soy el host, llamar a PantallaJugadores con host = true, nombre
                      _crearPulsado();
                    },
                    label: const Text(
                      "Crear",
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
                    backgroundColor: Colors.red[900],
                    extendedPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 12,
                    ),
                  ),
                  // TODO: Cambiar por ElevatedButton
                  FloatingActionButton.extended(
                    splashColor: Colors.yellow,
                    onPressed: () {
                      // TODO: No soy el host, llamar a PantallaJugadores con host = false, nombre
                      _unirsePulsado();
                    },
                    label: const Text(
                      "Unirse",
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
                    backgroundColor: Colors.red[900],
                    extendedPadding: const EdgeInsets.all(12),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
