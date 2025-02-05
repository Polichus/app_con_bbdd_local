import 'package:app_con_bbdd_local/componentes/boton_personalizado.dart';
import 'package:app_con_bbdd_local/componentes/boton_volver_atras.dart';
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
  bool mostrarError = false;
  String mensajeError = "";

  @override
  void initState() {
    super.initState();

    // Agregar listeners para ocultar errores cuando el usuario escriba algo
    widget.controller_nom.addListener(_ocultarError);
    widget.controller_contrasenya.addListener(_ocultarError);

    if (_boxHive.get("box_login") == null) {
      db.crearDadesExemple();
    } else {
      db.carregarDades();
    }
  }

  @override
  void dispose() {
    widget.controller_nom.removeListener(_ocultarError);
    widget.controller_contrasenya.removeListener(_ocultarError);
    super.dispose();
  }

  void _ocultarError() {
    if (mostrarError &&
        (widget.controller_nom.text.isNotEmpty ||
            widget.controller_contrasenya.text.isNotEmpty)) {
      setState(() {
        mostrarError = false;
      });
    }
  }

  void registrarte(BuildContext context) {
    String usuario = widget.controller_nom.text;
    String contrasenya = widget.controller_contrasenya.text;

    if (usuario.isEmpty || contrasenya.isEmpty) {
      setState(() {
        mostrarError = true;
        mensajeError = "Tienes que rellenar los campos";
      });
      return;
    }

    // Buscar si el usuario ya existe
    var usuarioExistente = db.tasques_llista.firstWhere(
      (item) => item["usuario"] == usuario,
      orElse: () => null,
    );

    if (usuarioExistente != null) {
      if (usuarioExistente["contraseña"] == contrasenya) {
        setState(() {
          mostrarError = true;
          mensajeError = "El usuario ya esta registrado.";
        });
      } else {
        setState(() {
          mostrarError = true;
          mensajeError = "El usuario ya esta registrado.";
        });
      }
      return;
    }

    // Guardar el nuevo usuario si no existe
    db.tasques_llista.add({"usuario": usuario, "contraseña": contrasenya});
    db.actualizarDades();

    widget.controller_nom.clear();
    widget.controller_contrasenya.clear();

    // Navegar a la pantalla de inicio de sesión
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const PaginaInicioSesion()),
    );
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
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 10, top: 10),
                child: Stack(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        BotonSalir(),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Registrarte", style: TextStyle(fontSize: 30)),
                      ],
                    ),
                  ],
                ),
              ),
              const Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 10, left: 10),
                    child: Text("Nombre de Usuario:"),
                  ),
                ],
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
              const Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 10, left: 10),
                    child: Text("Contraseña:"),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: TextField(
                  controller: widget.controller_contrasenya,
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
              if (mostrarError)
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
                  registrarte(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
