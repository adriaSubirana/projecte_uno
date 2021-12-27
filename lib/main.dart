// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:projecte_uno/clases/Jugador.dart';
import 'package:projecte_uno/clases/Partida.dart';
import 'package:projecte_uno/pantallas/pantallaLogin/login.dart';

import 'pantallas/pantallaJuego/juego.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

var host = Jugador("host");
var partida = Partida();

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Uno',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: Scaffold(
        appBar: AppBar(
          toolbarHeight: 0,
        ),
        body: PantallaJuego(),
        /*body: Column(
          children: [
            StreamBuilder(
              stream: partidaSnapshots("5k9aj8mcVC6X5FOldq8o"),
              builder: (
                BuildContext context,
                AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>> snapshot,
              ) {
                if (!snapshot.hasData) {
                  return Expanded(
                      child: const Center(child: CircularProgressIndicator()));
                }
                final doc = snapshot.data!;
                final data = doc.data();

                return Expanded(
                    child: Center(child: Text("${data?['turno']}")));
              },
            ),
            Expanded(child: PantallaJuego()),
          ],
        ),*/
      ),
    );
  }
}
