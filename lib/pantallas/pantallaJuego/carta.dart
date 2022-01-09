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
              padding: const EdgeInsets.all(6),
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
                                vertical: 16, horizontal: 16),
                            child: cardSymbol(codigo, Colors.white)),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Center(
                          child: RotationTransition(
                            turns: const AlwaysStoppedAnimation(40 / 360),
                            child: ClipOval(
                              child: Container(
                                height: 320,
                                width: 195,
                                decoration: BoxDecoration(
                                  color: codigo[1] == ' ' || codigo[1] == 'r'
                                      ? Colors.red
                                      : Colors.white,
                                ),
                                child: Center(
                                  child: RotationTransition(
                                    turns:
                                        const AlwaysStoppedAnimation(-40 / 360),
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
                        child: RotationTransition(
                          turns: const AlwaysStoppedAnimation(180 / 360),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 16, horizontal: 16),
                            child: cardSymbol(codigo, Colors.white),
                          ),
                        ),
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

Widget cardSymbol(String s, Color c) {
  final double size = c == Colors.white ? 56 : 112;
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
      return size == 56
          ? Text(
              "+4",
              style: TextStyle(
                color: c,
                fontWeight: FontWeight.bold,
                fontSize: size,
              ),
            )
          : Stack(
              children: const [
                Padding(
                  padding: EdgeInsets.fromLTRB(96, 32, 0, 16),
                  child: Card(
                    elevation: 0,
                    child: Padding(
                      padding: EdgeInsets.all(1),
                      child: Card(
                        elevation: 0,
                        color: Colors.green,
                        child: SizedBox(
                          height: 90,
                          width: 58,
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(64, 96, 0, 16),
                  child: Card(
                    elevation: 0,
                    child: Padding(
                      padding: EdgeInsets.all(1),
                      child: Card(
                        elevation: 0,
                        color: Colors.blue,
                        child: SizedBox(
                          height: 90,
                          width: 58,
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(32, 64, 0, 16),
                  child: Card(
                    elevation: 0,
                    child: Padding(
                      padding: EdgeInsets.all(1),
                      child: Card(
                        elevation: 0,
                        color: Colors.red,
                        child: SizedBox(
                          height: 90,
                          width: 58,
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 128, 96, 32),
                  child: Card(
                    elevation: 0,
                    child: Padding(
                      padding: EdgeInsets.all(1),
                      child: Card(
                        elevation: 0,
                        color: Colors.amber,
                        child: SizedBox(
                          height: 90,
                          width: 58,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
    } else {
      return size == 56
          ? Text(
              "+2",
              style: TextStyle(
                color: c,
                fontWeight: FontWeight.bold,
                fontSize: size,
              ),
            )
          : Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 48, 0, 0),
                  child: Card(
                    elevation: 0,
                    child: Padding(
                      padding: const EdgeInsets.all(1),
                      child: Card(
                        elevation: 0,
                        color: c,
                        child: const SizedBox(
                          height: 105,
                          width: 75,
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(40, 0, 0, 0),
                  child: Card(
                    elevation: 0,
                    child: Padding(
                      padding: const EdgeInsets.all(1),
                      child: Card(
                        elevation: 0,
                        color: c,
                        child: const SizedBox(
                          height: 105,
                          width: 75,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
    }
  } else if (s[1] == '@') {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: size == 56 ? 8 : 0),
      child: RotationTransition(
        turns: const AlwaysStoppedAnimation(40 / 360),
        child: ClipOval(
          child: SizedBox(
            height: size == 56 ? 60 : 300,
            width: size == 56 ? 35 : 175,
            child: Center(
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Container(
                      color: Colors.red,
                      height: size == 56 ? 60 / 2 : 300 / 2,
                      width: size == 56 ? 35 / 2 : 175 / 2,
                    ),
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: Container(
                      color: Colors.blue,
                      height: size == 56 ? 60 / 2 : 300 / 2,
                      width: size == 56 ? 35 / 2 : 175 / 2,
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Container(
                      color: Colors.amber,
                      height: size == 56 ? 60 / 2 : 300 / 2,
                      width: size == 56 ? 35 / 2 : 175 / 2,
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Container(
                      color: Colors.green,
                      height: size == 56 ? 60 / 2 : 300 / 2,
                      width: size == 56 ? 35 / 2 : 175 / 2,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  } else if (s[1] == '6' || s[1] == '9') {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Text(
        s[1],
        style: TextStyle(
            color: c,
            fontWeight: FontWeight.bold,
            fontSize: size,
            decoration: TextDecoration.underline),
      ),
    );
  } else if (s[1] == 'r') {
    if (size == 112) {
      return const RotationTransition(
        turns: AlwaysStoppedAnimation(-20 / 360),
        child: Padding(
          padding: EdgeInsets.only(left: 2),
          child: Text(
            'Robar',
            style: TextStyle(
                color: Colors.yellow,
                fontSize: 72,
                shadows: [
                  Shadow(
                    color: Colors.black,
                    offset: Offset(-8, 6),
                    blurRadius: 3,
                  )
                ],
                fontWeight: FontWeight.bold),
          ),
        ),
      );
    } else
      return const Text(' ');
  } else {
    return Text(
      " ${s[1]} ",
      style: TextStyle(
        color: c,
        fontWeight: FontWeight.bold,
        fontSize: size,
      ),
    );
  }
}
