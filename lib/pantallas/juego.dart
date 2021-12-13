// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:projecte_uno/pantallas/pantallaJuego/boton_abandonar.dart';

class PantallaJuego extends StatefulWidget {
  const PantallaJuego({Key? key}) : super(key: key);

  @override
  _PantallaJuegoState createState() => _PantallaJuegoState();
}

class _PantallaJuegoState extends State<PantallaJuego> {
  @override
  Widget build(BuildContext context) {
    return Abandonar();
  }
}
