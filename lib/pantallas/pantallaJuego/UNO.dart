import 'package:flutter/material.dart';
import 'package:projecte_uno/clases/jugador.dart';

class Uno extends StatefulWidget {
  final Jugador j1;
  const Uno({Key? key, required this.j1}) : super(key: key);

  @override
  _UnoState createState() => _UnoState();
}

class _UnoState extends State<Uno> {
  late bool _pulsado;
  late bool _estado;

  @override
  void initState() {
    super.initState();
    _pulsado = false;
    _estado = widget.j1.uno;
  }

  void _unoPulsado() {
    setState(() {
      if (widget.j1.cartas.length == 1) {
        widget.j1.uno = true;
        _estado = widget.j1.uno;
      } else {
        widget.j1.uno = false;
        _estado = widget.j1.uno;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      child: GestureDetector(
        onLongPress: () {
          setState(() {
            if (_estado == true) {
              _pulsado = true;
            } else {
              _pulsado = false;
            }
          });
        },
        onLongPressUp: () {
          setState(() {
            _pulsado = false;
          });
        },
        child: ElevatedButton(
          onPressed: () {
            _unoPulsado();
          },
          child: const Text(
            "UNO",
            style: TextStyle(
                color: Colors.yellow,
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
            primary: _pulsado ? Colors.red : Colors.blue,
            padding: const EdgeInsets.all(12),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
        ),
      ),
    );
  }
}
