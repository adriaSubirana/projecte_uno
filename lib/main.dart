// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:projecte_uno/pantallas/juego.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

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
        body: Column(
          children: [
            /*StreamBuilder(
              stream: FirebaseFirestore.instance
                  .doc("/Partidas/5k9aj8mcVC6X5FOldq8o")
                  .snapshots(),
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
            ),*/
            Expanded(child: PantallaJuego()),
          ],
        ),
      ),
    );
  }
}