import 'package:app_con_bbdd_local/componentes/cbarra_navegacion.dart';
import 'package:flutter/material.dart';

class BotonSalir extends StatelessWidget {
  const BotonSalir({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton.icon(
        onPressed: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => CbarraNavegacion(),
            ),
          );
        },
        icon: const Icon(Icons.exit_to_app),
        label: const Text('Salir'),
      ),
    );
  }
}
