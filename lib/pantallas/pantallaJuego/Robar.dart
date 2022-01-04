import 'package:flutter/material.dart';
import 'package:projecte_uno/clases/Partida.dart';
import 'package:projecte_uno/clases/Jugador.dart';

class Robar extends StatefulWidget {
  final Jugador j1;
  final Partida p1;
  const Robar({Key? key, required this.j1, required this.p1}) : super(key: key);

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

  void _robarPulsado() {
    setState(() {
      _pulsado = !_pulsado;
      _robarCarta();
    });
  }

  void _robarCarta() {
    widget.j1.addCarta(widget.p1.cartasRobar[
        0]); //código de la primera carta de la lista de cartas robar
    widget.p1.cartasRobar.removeAt(0);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(12),
        child: ElevatedButton(
            onPressed: () {
              _robarPulsado();
            },
            child: Text(
              "${widget.p1.cartasRobar.length}",
              style: const TextStyle(
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
            style: ElevatedButton.styleFrom(
              primary: Colors.green,
              padding: const EdgeInsets.all(12),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
            )));
  }
}
