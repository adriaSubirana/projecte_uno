import 'package:flutter/material.dart';

class Abandonar extends StatefulWidget {
  const Abandonar({Key? key}) : super(key: key);

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
              title: const Text("Abandonar"),
              content: const Text("Seguro que quieres abandonar la partida?"),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context, "Cancel"),
                  child: const Text("Cancelar"),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context, "Salir");
                  },
                  child: const Text("Salir"),
                )
              ],
            );
          },
        );
      },
      icon: const Icon(
        Icons.close,
        color: Colors.red,
      ),
    );
  }
}
