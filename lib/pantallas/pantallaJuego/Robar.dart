import 'package:flutter/material.dart';
import 'package:projecte_uno/pantallas/pantallaJuego/carta.dart';

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
        child: Carta(codigo: widget.onPressed != null ? 'kr' : 'k '),
      ),
    );
  }
}
