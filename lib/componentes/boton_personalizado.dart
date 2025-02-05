import 'package:app_con_bbdd_local/componentes/cbarra_navegacion.dart';
import 'package:app_con_bbdd_local/componentes/pagina_registro.dart';
import 'package:flutter/material.dart';

class BotonPersonalizado extends StatelessWidget {
  final Function()? accioBoto;

  const BotonPersonalizado({super.key, required this.accioBoto});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: accioBoto,
        child: Container(
            decoration: BoxDecoration(
              color: Colors.yellow[900],
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Text("Confirmar Sesión"),
            )),
      ),
    );
  }
}
