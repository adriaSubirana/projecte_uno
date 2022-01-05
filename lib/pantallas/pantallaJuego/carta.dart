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
                          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                          child: Text(
                            codigo[1],
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 48,
                            ),
                          ),
                        ),
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
                                    turns: const AlwaysStoppedAnimation(-45 / 360),
                                    child: Text(
                                      codigo[1],
                                      style: TextStyle(
                                        color: cardColor[codigo[0]],
                                        fontWeight: FontWeight.bold,
                                        fontSize: 96,
                                      ),
                                    ),
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
                          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                          child: Text(
                            codigo[1],
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 48,
                            ),
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
