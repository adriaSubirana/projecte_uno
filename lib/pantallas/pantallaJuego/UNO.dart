// ignore_for_file: file_names

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:projecte_uno/clases/Jugador.dart';

class UNO extends StatefulWidget {
  late Jugador j1;
  UNO({Key? key, required this.j1}) : super(key: key);

  @override
  _UNOState createState() => _UNOState();
}

class _UNOState extends State<UNO> {
  late bool _pulsado;
  late bool _estado;

  @override
  void initState() {
    super.initState();
    _pulsado = false;
    _estado = widget.j1.uno;
  }

  void _UNOPulsado() {
    setState(() {
      if (widget.j1.cartas.length == 1) {
        widget.j1.setUno(true);
        _estado = widget.j1.getUno();
      } else {
        widget.j1.setUno(false);
        _estado = widget.j1.getUno();
      }
    });
  }

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
          child: FloatingActionButton.extended(
            splashColor: _estado ? Colors.red : Colors.blue,
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
            backgroundColor: _pulsado ? Colors.red : Colors.blue,
            focusElevation: 3,
            extendedPadding: EdgeInsets.all(8),
            foregroundColor: Colors.white,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
        ));
  }
}
