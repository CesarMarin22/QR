import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_qr/providers/auth_provider.dart';
import 'package:proyecto_qr/screens/escoger.dart';
import 'package:proyecto_qr/screens/sesion.dart';
import 'package:proyecto_qr/providers/serial_number.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SerialNumberModel('')),
        // Otros providers si los tienes
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AuthProvider(),
      child: MaterialApp(
        title: "Proyecto QR",
        home: LoginScreen(),
      ),
    );
  }
}
