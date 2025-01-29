import 'package:app_con_bbdd_local/componentes/boton_personalizado.dart';
import 'package:app_con_bbdd_local/componentes/pagina_inicio_sesion.dart';
import 'package:app_con_bbdd_local/data/BBDD.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class PaginaRegistro extends StatefulWidget {
  final TextEditingController controller_nom;
  final TextEditingController controller_contrasenya;

  const PaginaRegistro({
    super.key,
    required this.controller_nom,
    required this.controller_contrasenya,
  });

  @override
  State<PaginaRegistro> createState() => _PaginaRegistroState();
}

class _PaginaRegistroState extends State<PaginaRegistro> {
  final Box _boxHive = Hive.box("box_login");
  Bbdd db = Bbdd();

  void registrarte(BuildContext context) {
    if (widget.controller_nom.text == "" || widget.controller_contrasenya.text == "") {
      print("Tienes que rellenar los campos");
    } else {
      db.tasques_llista.add({
        "usuario": widget.controller_nom.text,
        "contraseña": widget.controller_contrasenya.text,
      });
      db.actualizarDades();
      widget.controller_nom.clear();
      widget.controller_contrasenya.clear();
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const PaginaInicioSesion(),
        ),
      );
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    if (_boxHive.get("box_login") == null) {
      //Si està buida, carreguem les dades d'exemple
      db.crearDadesExemple();
    } else {
      db.carregarDades();
    }

    super.initState();
  }

 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 10, top: 10),
              child: Center(
                child: Text(
                  "Registrarte",
                  style: TextStyle(
                    fontSize: 30,
                  ),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 10, left: 10),
              child: Text(
                "Nombre de Usuario:",
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: widget.controller_nom,
                cursorColor: Colors.orange[400],
                decoration: InputDecoration(
                  hintText: "Usuario",
                  border: const OutlineInputBorder(),
                  filled: true,
                  fillColor: Colors.teal[100],
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(10),
              child: Text(
                "Contraseña:",
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: widget.controller_contrasenya,
                cursorColor: Colors.orange[400],
                decoration: InputDecoration(
                  hintText: "Password",
                  border: const OutlineInputBorder(),
                  filled: true,
                  fillColor: Colors.teal[100],
                ),
              ),
            ),
            BotonPersonalizado(
              accioBoto: () {
                registrarte(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
