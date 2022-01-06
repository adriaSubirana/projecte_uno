import 'package:flutter/material.dart';
import 'package:projecte_uno/clases/partida.dart';

class Robar extends StatefulWidget {
  final Partida partida;
  final void Function()? onPressed;
  const Robar({Key? key, required this.partida, required this.onPressed})
      : super(key: key);

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
    return Container(
      padding: const EdgeInsets.all(12),
      child: ElevatedButton(
        onPressed: widget.onPressed,
        child: Text(
          "${widget.partida.cartasRobar.length}",
          style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              shadows: [
                Shadow(
                  color: Colors.black,
                  offset: Offset(0, 3),
                  blurRadius: 3,
                )
              ],
              fontWeight: FontWeight.bold),
        ),
        style: ElevatedButton.styleFrom(
          primary: Colors.green,
          padding: const EdgeInsets.all(12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
    );
  }
}
