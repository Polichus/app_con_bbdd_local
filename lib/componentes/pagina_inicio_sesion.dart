import 'package:app_con_bbdd_local/componentes/boton_personalizado.dart'; 
import 'package:app_con_bbdd_local/componentes/cbarra_navegacion.dart';
import 'package:app_con_bbdd_local/data/BBDD.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class PaginaInicioSesion extends StatefulWidget {
  const PaginaInicioSesion({super.key});

  @override
  State<PaginaInicioSesion> createState() => _PaginaInicioSesionState();
}

class _PaginaInicioSesionState extends State<PaginaInicioSesion> {
  final TextEditingController controller_nom = TextEditingController();
  final TextEditingController controller_contrasenya = TextEditingController();
  String mensajeError = "";

  @override
  void initState() {
    super.initState();
    controller_nom.addListener(_ocultarError);
    controller_contrasenya.addListener(_ocultarError);
  }

  @override
  void dispose() {
    controller_nom.removeListener(_ocultarError);
    controller_contrasenya.removeListener(_ocultarError);
    controller_nom.dispose();
    controller_contrasenya.dispose();
    super.dispose();
  }

  void _ocultarError() {
    if (mensajeError.isNotEmpty &&
        (controller_nom.text.isNotEmpty || controller_contrasenya.text.isNotEmpty)) {
      setState(() {
        mensajeError = "";
      });
    }
  }

  void iniciarSesion(BuildContext context) {
    Bbdd db = Bbdd();
    db.carregarDades();

    if (controller_nom.text.isEmpty || controller_contrasenya.text.isEmpty) {
      setState(() {
        mensajeError = "Tienes que rellenar los campos";
      });
      return;
    }

    bool credencialesCorrectas = false;
    for (var usuario in db.tasques_llista) {
      if (usuario["usuario"] == controller_nom.text &&
          usuario["contraseña"] == controller_contrasenya.text) {
        String mensajeBienvenida =
            "Hola, ${controller_nom.text} has iniciado sesión correctamente";

        controller_nom.clear();
        controller_contrasenya.clear();

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CbarraNavegacion(textoBenviguda: mensajeBienvenida),
          ),
        );
        return;
      }
    }

    setState(() {
      mensajeError = "Usuario o contraseña incorrectos";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow[300],
      body: Padding(
        padding: const EdgeInsets.only(left: 700, top: 300),
        child: Container(
          color: Colors.yellow[700],
          height: 400,
          width: 500,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 10, top: 10),
                child: Center(
                  child: Text(
                    "Iniciar Sesión",
                    style: TextStyle(fontSize: 30),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 10, left: 10),
                child: Text("Nombre de Usuario:"),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: TextField(
                  controller: controller_nom,
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
                child: Text("Contraseña:"),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: TextField(
                  controller: controller_contrasenya,
                  cursorColor: Colors.orange[400],
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: "Password",
                    border: const OutlineInputBorder(),
                    filled: true,
                    fillColor: Colors.teal[100],
                  ),
                ),
              ),
              if (mensajeError.isNotEmpty)
                Container(
                  padding: const EdgeInsets.all(10),
                  margin: const EdgeInsets.only(top: 10),
                  decoration: BoxDecoration(
                    color: Colors.red[200],
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.warning, color: Colors.red),
                      const SizedBox(width: 8),
                      Text(
                        mensajeError,
                        style: const TextStyle(
                            color: Colors.red, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              const SizedBox(height: 20),
              BotonPersonalizado(
                accioBoto: () {
                  iniciarSesion(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

