import 'package:hive/hive.dart';

class Bbdd {
  List tasques_llista = [];

  final Box _boxDeLaHive = Hive.box("box_login");

  void crearDadesExemple() {
    tasques_llista = [
      {
        "usuario": "",
        "password": "",
      },
    ];
  }

  void carregarDades() {
    tasques_llista = _boxDeLaHive.get("box_login");
  }

  void actualizarDades() {
    _boxDeLaHive.put("box_login", tasques_llista);
  }
}
