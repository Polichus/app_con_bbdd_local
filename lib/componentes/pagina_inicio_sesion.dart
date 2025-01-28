import 'package:app_con_bbdd_local/componentes/boton_personalizado.dart';
import 'package:app_con_bbdd_local/componentes/cbarra_navegacion.dart';
import 'package:flutter/material.dart';

class PaginaInicioSesion extends StatelessWidget {
  final TextEditingController controller_nom;
  final TextEditingController controller_contrasenya;

  const PaginaInicioSesion({
    super.key,
    required this.controller_nom,
    required this.controller_contrasenya,
  });

  void iniciar_sesion(BuildContext context) {

    if(controller_nom.text == "Pol" ){
      
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const CbarraNavegacion(),
      ),
    );
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
                  "Iniciar Sesion",
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
              child: Text(
                "Contraseña:",
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: controller_contrasenya,
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
                iniciar_sesion(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
