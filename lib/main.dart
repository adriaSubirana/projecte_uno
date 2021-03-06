import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:projecte_uno/clases/jugador.dart';
import 'package:projecte_uno/clases/partida.dart';
import 'package:projecte_uno/pantallas/login.dart';
import 'package:projecte_uno/pantallas/pantalla_jugadores.dart';
import 'package:flutter/services.dart';

import 'pantallas/pantallaJuego/juego.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
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
      debugShowCheckedModeBanner: false,
      title: 'Uno',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const Login(),
        '/espera': (context) => PantallaJugadores(),
        '/juego': (context) => PantallaJuego(),
      },
      //ffff
    );
  }
}
