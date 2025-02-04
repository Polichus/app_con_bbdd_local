import 'package:app_con_bbdd_local/componentes/boton_personalizado.dart';
import 'package:app_con_bbdd_local/componentes/cbarra_navegacion.dart';
import 'package:app_con_bbdd_local/data/BBDD.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class PaginaInicioSesion extends StatelessWidget {
  
  const PaginaInicioSesion({
    super.key,
    
  });

  void iniciar_sesion(
      BuildContext context,
      TextEditingController controller_nom,
      TextEditingController controller_contrasenya,
      
      ) {
    //final Box _boxDeLaHive = Hive.box("box_login");
    Bbdd db = Bbdd();
    db.carregarDades();
    print(db.tasques_llista);
    if (controller_nom.text == "" || controller_contrasenya.text == "") {
      print("Tienes que rellenar los campos");
    } else {

      for (int i = 0; i < db.tasques_llista.length; i++) {
        
        if (db.tasques_llista[i]["usuario"]== controller_nom.text && db.tasques_llista[i]["contraseña"] == controller_contrasenya.text) {
          print("Hola," + " " + controller_nom.text + " " + "has iniciado sesion correctamente");
          String textBenviguda = "Hola," + " " + controller_nom.text +  " " + "has iniciado sesion correctamente";
          controller_nom.clear();
          controller_contrasenya.clear();
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CbarraNavegacion(textoBenviguda: textBenviguda,),
            ),
          );
          
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController controller_nom = TextEditingController();
    TextEditingController controller_contrasenya = TextEditingController();

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
                iniciar_sesion(context, controller_nom, controller_contrasenya);
              },
            ),
          ],
        ),
      ),
    );
  }
}
