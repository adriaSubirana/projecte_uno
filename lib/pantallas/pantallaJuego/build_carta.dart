import 'package:flutter/material.dart';

const Map<String, Color> cardColor = {
  'r': Colors.red,
  'g': Colors.green,
  'b': Colors.blue,
  'y': Colors.amber,
  'k': Colors.black,
};

class Carta extends StatelessWidget {
  final String codigo;

  const Carta({Key? key, required this.codigo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        debugPrint(codigo);
      },
      child: AspectRatio(
        aspectRatio: 2.5 / 3.5,
        child: Card(
          elevation: 20.0,
          color: cardColor[codigo[0]],
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
            child: Text(
              codigo[1],
              style: const TextStyle(
                color: Colors.white70,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
