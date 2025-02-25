import 'package:app_con_bbdd_local/componentes/cbarra_navegacion.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async{

  await Hive.initFlutter();
  await Hive.openBox("box_login");

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: CbarraNavegacion(),
      ),
    );
  }
}
//flutter run -d chrome --web-port 53123 //Esto es para que no cambie de puerto

