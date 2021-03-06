import 'package:flutter/material.dart';
import 'package:projecte_uno/pantallas/pantallaJuego/carta.dart';

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
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        return Align(
          alignment: Alignment.topLeft,
          widthFactor: index != widget.cartas.length - 1 ? 0.45 : 1,
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
