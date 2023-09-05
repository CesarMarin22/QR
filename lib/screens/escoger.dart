import 'package:flutter/material.dart';
import 'package:proyecto_qr/screens/lector_qr.dart';
import 'package:proyecto_qr/screens/sesion.dart';
import 'lector_manual.dart';

class eleccion extends StatefulWidget {
  const eleccion({super.key});

  @override
  State<eleccion> createState() => _eleccion();
}

class _eleccion extends State<eleccion> {
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
//////////// cuerpo de la aplicacion/////////////////////////
        body: Center(
            child: Padding(
          padding: const EdgeInsets.only(top: 30),
          child: Column(
            children: [
              const Text(
                '¿QUE DESEAS HACER?',
                style: TextStyle(
                  fontSize: 30,
                ),
              ),
              const SizedBox(
                height: 100,
              ),

////////////////////////////boton informacion////////////////////////////////////////////////////
              SizedBox(
                width: 200,
                height: 60,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => QRScannerPage()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      backgroundColor: const Color.fromARGB(255, 243, 138, 0),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side:
                              const BorderSide(color: Colors.black, width: 5))),
                  child: const Text(
                    'LEER QR',
                    style: TextStyle(fontSize: 20, color: Colors.black),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
/////////////////Termino de boton informacion////////////////////////////////////////////
              ///
              ////////////////espaciado entre botones///////////////////////////////////////////////////
              const SizedBox(
                height: 65,
              ),

////////////////////termino Espaciado entre botones////////////////////////////////////
              ///
//////////////////boton historia de servicios//////////////////////////////////////////////
              SizedBox(
                width: 200,
                height: 60,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => InputPage()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      backgroundColor: const Color.fromARGB(255, 243, 138, 0),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side:
                              const BorderSide(color: Colors.black, width: 5))),
                  child: const Text(
                    'INGRESAR ARTICULO MANUALMENTE',
                    style: TextStyle(fontSize: 20, color: Colors.black),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
///////////////////////fin boton historial de servicios/////////////////////////////
////////////////////////////Termino boton Reporte de instalacion/////////////////////////
              ////////////////espaciado entre botones///////////////////////////////////////////////////
              const SizedBox(
                height: 80,
              ),

////////////////////termino Espaciado entre botones////////////////////////////////////
              ///
/////////////////////boton REGRESAR //////////////////////////////////////////////
              SizedBox(
                width: 200,
                height: 90,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => LoginScreen()),
                      (Route<dynamic> route) => false,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      backgroundColor: const Color.fromARGB(255, 250, 2, 2),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side:
                              const BorderSide(color: Colors.black, width: 5))),
                  child: const Text(
                    'CERRAR SESIÓN',
                    style: TextStyle(fontSize: 20, color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
///////////////////////fin boton historial de servicios/////////////////////////////
            ],
          ),
        )),
/////////////////configuracion Fotter/////////////////////////////////////////////////////
        bottomNavigationBar: const BottomAppBar(
          color: Color.fromARGB(255, 29, 29, 27),
          shape: CircularNotchedRectangle(),
          child: SizedBox(
            height: 50,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Copyright ©2023, Todos los Derechos Reservados.',
                    style: TextStyle(
                        fontWeight: FontWeight.w300,
                        fontSize: 12.0,
                        color: Color.fromARGB(255, 255, 255, 255)),
                  ),
                  Text(
                    'Powered by IPL',
                    style: TextStyle(
                        fontWeight: FontWeight.w300,
                        fontSize: 12.0,
                        color: Color.fromARGB(255, 255, 255, 255)),
                  ),
                ],
              ),
            ),
          ),
        )
        ///////////////// fin de configuracion Fotter/////////////////////////////////////////////////////
        );
  }
}
