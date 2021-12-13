// ignore_for_file: file_names

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:projecte_uno/clases/jugador.dart';

class UNO extends StatefulWidget {
  late Jugador j1;
  UNO({Key? key, required this.j1}) : super(key: key);

  @override
  _UNOState createState() => _UNOState();
}

class _UNOState extends State<UNO> {
  late bool _pulsado;

  @override
  void initState() {
    super.initState();
    _pulsado = false;
  }

  void _UNOPulsado() {
    setState(() {
      _pulsado = !_pulsado;
      if (widget.j1.cartas.length == 1) {
        widget.j1.setUno(true);
      } else {
        widget.j1.setUno(false);
      }
    });
  }

  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(12),
        child: FloatingActionButton.extended(
          splashColor: Colors.white,
          onPressed: () {
            _UNOPulsado();
          },
          // icon: Icon(Icons.),
          label: Text(
            "UNO",
            style: TextStyle(
                color: Colors.yellow,
                fontSize: 20,
                shadows: [
                  Shadow(
                    color: Color.fromRGBO(255, 255, 0, 10),
                    offset: Offset(0, 3),
                    blurRadius: 3,
                  )
                ],
                fontWeight: FontWeight.bold),
          ),
          backgroundColor: _pulsado ? Colors.blue : Colors.red,
          focusElevation: 3,
          extendedPadding: EdgeInsets.all(8),
          foregroundColor: Colors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ));
  }
}
