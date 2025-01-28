import 'package:app_con_bbdd_local/componentes/pagina_inicio_sesion.dart';
import 'package:app_con_bbdd_local/componentes/pagina_registro.dart';
import 'package:flutter/material.dart';

class CbarraNavegacion extends StatelessWidget {
  const CbarraNavegacion({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    TextEditingController controller_nom = TextEditingController();
    TextEditingController controller_contrasenya = TextEditingController();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        drawer: Drawer(
          backgroundColor: Colors.deepOrange[100],
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                const SizedBox(
                  height: 40,
                ),
                Icon(
                  Icons.logout_outlined,
                  size: 110,
                  color: Colors.deepOrange[300],
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "LOGIN",
                  style: TextStyle(
                    color: Colors.deepOrange[400],
                    fontSize: 12,
                    letterSpacing: 8,
                  ),
                ),
                Divider(
                  color: Colors.deepOrange[300],
                  thickness: 2,
                ),
                const SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context, 
                      MaterialPageRoute(
                        builder: (context) => PaginaRegistro(
                          controller_nom: controller_nom, 
                          controller_contrasenya: controller_contrasenya,
                        ),
                      ),
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,  
                    children: [
                      Text(
                        "Registrarte",
                        style: TextStyle(
                          letterSpacing: 6,
                          color: Colors.deepOrange[400],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PaginaInicioSesion(
                          controller_nom: controller_nom,
                          controller_contrasenya: controller_contrasenya,
                        ),
                      ),
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Iniciar Session",
                        style: TextStyle(
                          letterSpacing: 6,
                          color: Colors.deepOrange[400],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
        appBar: AppBar(
          backgroundColor: Colors.indigoAccent,
          foregroundColor: Colors.white,
          titleTextStyle: const TextStyle(
            fontStyle: FontStyle.italic,
            color: Colors.white,
            fontSize: 28,
          ),
          title: const Text("Pagina para Logearte"),
        ),
        body: const Center(
          child: Text(""),
        ),
        backgroundColor: Colors.deepPurpleAccent[100],
      ),
    );
  }
}
