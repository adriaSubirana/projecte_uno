import 'package:flutter/material.dart';

class Abandonar extends StatefulWidget {
  final bool host;
  final void Function()? salir;
  final dynamic then;
  const Abandonar(
      {Key? key, required this.host, required this.salir, required this.then})
      : super(key: key);

  @override
  _AbandonarState createState() => _AbandonarState();
}

class _AbandonarState extends State<Abandonar> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              backgroundColor: const Color(0xFF515151),
              title: const Text(
                "Abandonar",
                style: TextStyle(color: Colors.white70),
              ),
              content: Text(
                !widget.host
                    ? "Seguro que quieres abandonar la partida?"
                    : "Seguro que quieres abandonar la partida?\nLa partida se eliminará y el juego acabará para todos",
                style: const TextStyle(color: Colors.white70),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Cancelar"),
                ),
                TextButton(
                  onPressed: widget.salir,
                  child: const Text("Salir"),
                )
              ],
            );
          },
        ).then(widget.then);
      },
      icon: const Icon(
        Icons.close,
        color: Colors.red,
      ),
    );
  }
}
