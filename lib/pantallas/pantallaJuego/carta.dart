import 'package:flutter/material.dart';

const Map<String, Color> cardColor = {
  'r': Colors.red,
  'g': Colors.green,
  'b': Colors.blue,
  'y': Colors.amber,
  'k': Colors.black,
};

Widget cardSymbol(String s, Color c) {
  final double size = c == Colors.white ? 48 : 112;
  if (s[1] == '#') {
    return Icon(
      Icons.not_interested,
      color: c,
      size: size,
    );
  } else if (s[1] == '%') {
    return Icon(
      Icons.autorenew_rounded,
      color: c,
      size: size,
    );
  } else if (s[1] == '€') {
    if (s[0] == 'k') {
      // TODO: Cambiar icono del centro
      return Text(
        "+4",
        style: TextStyle(
          color: c,
          fontWeight: FontWeight.bold,
          fontSize: size,
        ),
      );
    } else {
      // TODO: Cambiar icono del centro
      return Text(
        "+2",
        style: TextStyle(
          color: c,
          fontWeight: FontWeight.bold,
          fontSize: size,
        ),
      );
    }
    // TODO: Simbolo cambio de color
  } else {
    return Text(
      s[1],
      style: TextStyle(
        color: c,
        fontWeight: FontWeight.bold,
        fontSize: size,
      ),
    );
  }
}

class Carta extends StatelessWidget {
  final String codigo;
  final void Function(String)? onPressed; // una funció: void f()

  const Carta({
    Key? key,
    required this.codigo,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (onPressed != null) onPressed!(codigo);
      },
      child: AspectRatio(
        aspectRatio: 2.5 / 3.5,
        child: FittedBox(
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            elevation: 20.0,
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                elevation: 0,
                color: cardColor[codigo[0]],
                child: SizedBox(
                  height: 350,
                  width: 250,
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 16, horizontal: 24),
                            child: cardSymbol(codigo, Colors.white)),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Center(
                          child: RotationTransition(
                            turns: const AlwaysStoppedAnimation(45 / 360),
                            child: ClipOval(
                              child: Container(
                                height: 320,
                                width: 180,
                                decoration: const BoxDecoration(
                                  //shape: BoxShape.circle,
                                  color: Colors.white,
                                ),
                                child: Center(
                                  child: RotationTransition(
                                    turns:
                                        const AlwaysStoppedAnimation(-45 / 360),
                                    child: cardSymbol(
                                        codigo, cardColor[codigo[0]]!),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 16, horizontal: 24),
                            child: cardSymbol(codigo, Colors.white)),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
