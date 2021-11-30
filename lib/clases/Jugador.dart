// ignore_for_file: file_names

import 'partida.dart';

class Jugador {
  late String nombre;
  bool uno = false;
  late bool host;
  List<String> cartas = [];
  Jugador(this.nombre, this.host);
  Jugador.copia(Jugador j1) {
    nombre = j1.getNombre();
    host = j1.gethost();
    uno = j1.getUno();
    cartas = j1.getCartas();
  }

  String getNombre() => nombre;
  bool getUno() => uno;
  bool gethost() => host;
  List<String> getCartas() => cartas;

  void setNombre(String nombre) => this.nombre = nombre;
  void setUno(bool uno) => this.uno = uno;
  void setCartas(List<String> cartas) => this.cartas = cartas;

  void addCarta(String cartaRobada) {
    cartas.add(cartaRobada);
  }
}

//var j1 = Jugador("Juan", false);
//var j2 = Jugador.copia(j1);
