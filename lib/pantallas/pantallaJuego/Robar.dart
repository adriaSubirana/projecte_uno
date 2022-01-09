import 'package:flutter/material.dart';

class Robar extends StatefulWidget {
  final void Function()? onPressed;
  const Robar({Key? key, required this.onPressed}) : super(key: key);

  @override
  _RobarState createState() => _RobarState();
}

class _RobarState extends State<Robar> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: MaterialButton(
        onPressed: widget.onPressed,
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
                  color: Colors.black,
                  child: SizedBox(
                    height: 350,
                    width: 250,
                    child: Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16),
                          child: Center(
                            child: RotationTransition(
                              turns: const AlwaysStoppedAnimation(40 / 360),
                              child: ClipOval(
                                child: Container(
                                  height: 320,
                                  width: 195,
                                  decoration: const BoxDecoration(
                                    color: Colors.red,
                                  ),
                                  child: Center(
                                    child: RotationTransition(
                                      turns: const AlwaysStoppedAnimation(
                                          -40 / 360),
                                      child: widget.onPressed != null
                                          ? const RotationTransition(
                                              turns: AlwaysStoppedAnimation(
                                                  -20 / 360),
                                              child: Padding(
                                                padding:
                                                    EdgeInsets.only(left: 2),
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
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                            )
                                          : const Text(" "),
                                    ),
                                  ),
                                ),
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
      ),
    );
  }
}
