import "package:flutter/material.dart";

class Informacion_Equipos extends StatelessWidget {
  const Informacion_Equipos({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 243, 138, 0),
        title: Center(
          child: Image.asset(
            'assets/logo_ipl_negro.png',
            width: 70,
            height: 70,
          ),
        ),
      ),
      body: Center(
        child: ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Regresar Menu')),
      ),
    );
  }
}
