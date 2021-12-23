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

  void _crear_pulsado() {
    setState(() {
      _crear = !_crear;
    });
  }

  void _unirse_pulsado() {
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
              Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  FloatingActionButton.extended(
                    splashColor: Colors.yellow,
                    onPressed: () {
                      _crear_pulsado();
                    },
                    label: Text(
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
                    extendedPadding:
                        EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                  )),
                  FloatingActionButton.extended(
                    splashColor: Colors.yellow,
                    onPressed: () {
                      _unirse_pulsado();
                    },
                    label: Text(
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
                    extendedPadding: EdgeInsets.all(12),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
