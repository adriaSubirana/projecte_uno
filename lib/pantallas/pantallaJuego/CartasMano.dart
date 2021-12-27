// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:projecte_uno/pantallas/pantallaJuego/build_carta.dart';

class CartasMano extends StatefulWidget {
  final List<String> cartas;
  final void Function(String) onPressed; // una funció: void f()

  const CartasMano({
    Key? key,
    required this.cartas,
    required this.onPressed,
  }) : super(key: key);

  @override
  _CartasManoState createState() => _CartasManoState();
}

class _CartasManoState extends State<CartasMano> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        return Align(
          alignment: Alignment.topLeft,
          widthFactor: 0.45,
          child: Carta(
            codigo: widget.cartas[index],
            onPressed: widget.onPressed,
          ),
        );
      },
      itemCount: widget.cartas.length,
    );
  }
}
