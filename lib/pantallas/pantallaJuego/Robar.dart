// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:projecte_uno/clases/Partida.dart';
import 'package:projecte_uno/clases/Jugador.dart';

class Robar extends StatefulWidget {
  late Jugador j1;
  late Partida p1;
  Robar({Key? key, required this.j1, required this.p1}) : super(key: key);

  @override
  _RobarState createState() => _RobarState();
}

class _RobarState extends State<Robar> {
  late bool _pulsado;
  @override
  void initState() {
    _pulsado = false;
    super.initState();
  }

  void _RobarPulsado() {
    setState(() {
      _pulsado = !_pulsado;
      _RobarCarta();
    });
  }

  void _RobarCarta() {
    widget.j1.addCarta(widget.p1.cartasRobar[
        0]); //código de la primera carta de la lista de cartas robar
    widget.p1.cartasRobar.removeAt(0);
  }

  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(12),
        child: FloatingActionButton.extended(
          splashColor: Colors.white,
          onPressed: () {
            _RobarPulsado();
          },
          // icon: Icon(Icons.),
          label: Text(
            "Robar",
            style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                shadows: [
                  Shadow(
                    color: Colors.black,
                    offset: Offset(0, 3),
                    blurRadius: 3,
                  )
                ],
                fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.green,
          focusElevation: 3,
          extendedPadding: EdgeInsets.all(12),
          foregroundColor: Colors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ));
  }
}
