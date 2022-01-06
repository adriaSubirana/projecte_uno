import 'package:flutter/material.dart';
import 'package:projecte_uno/pantallas/pantallaJuego/carta.dart';

late String cartamesaActualizada;

class CartaMesa extends StatelessWidget {
  final List<String> cartas;

  const CartaMesa({
    Key? key,
    required this.cartas,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Carta(codigo: cartas.last);
  }
}
