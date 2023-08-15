import 'package:flutter/material.dart';
import 'package:proyecto_qr/screens/informacion_equipos.dart';
import 'package:proyecto_qr/screens/menu_baterias.dart';
import 'package:proyecto_qr/screens/menu_cargadores.dart';
import 'package:proyecto_qr/screens/menu_equipos.dart';
import 'package:flutter/cupertino.dart';
import 'package:proyecto_qr/screens/prueba_sl.dart';
import 'package:proyecto_qr/screens/sesion.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: MyWidget());
  }
}
