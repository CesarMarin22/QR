import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:proyecto_qr/screens/InformacionEquipos.dart';

class menuEquipos extends StatefulWidget {
  const menuEquipos({super.key});

  @override
  State<menuEquipos> createState() => _menuEquipos();
}

class _menuEquipos extends State<menuEquipos> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 243, 138, 0),
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
              Text(
                'EQUIPOS',
                style: TextStyle(fontSize: 40),
              ),
              SizedBox(
                height: 70,
              ),

////////////////////////////boton informacion////////////////////////////////////////////////////
              Container(
                width: 200,
                height: 60,
                child: ElevatedButton(
                  onPressed: () {
                    // Acción a realizar cuando se presiona el botón
                  },
                  style: ElevatedButton.styleFrom(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      backgroundColor: Color.fromARGB(255, 243, 138, 0),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: BorderSide(color: Colors.black, width: 5))),
                  child: Text(
                    'INFORMACIÓN',
                    style: TextStyle(fontSize: 20, color: Colors.black),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
/////////////////Termino de boton informacion////////////////////////////////////////////
              ///
/////////////espaciado entre botones///////////////////////////////////////////////////
              SizedBox(
                height: 25,
              ),

////////////////////termino Espaciado entre botones////////////////////////////////////
              ///
///////////////boton reporte de instalacion//////////////////////////////////////////////

              Container(
                width: 200,
                height: 60,
                child: ElevatedButton(
                  onPressed: () {
                    // Acción a realizar cuando se presiona el botón
                  },
                  style: ElevatedButton.styleFrom(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      backgroundColor: Color.fromARGB(255, 243, 138, 0),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: BorderSide(color: Colors.black, width: 5))),
                  child: Text(
                    'REPORTE DE INSTALACIÓN',
                    style: TextStyle(fontSize: 20, color: Colors.black),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
/////////////////////////Termino boton Reporte de instalacion/////////////////////////
              ////////////////espaciado entre botones///////////////////////////////////////////////////
              SizedBox(
                height: 25,
              ),

////////////////////termino Espaciado entre botones////////////////////////////////////
              ///
//////////////////boton historia de servicios//////////////////////////////////////////////
              Container(
                width: 200,
                height: 60,
                child: ElevatedButton(
                  onPressed: () {
                    // Acción a realizar cuando se presiona el botón
                  },
                  style: ElevatedButton.styleFrom(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      backgroundColor: Color.fromARGB(255, 243, 138, 0),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: BorderSide(color: Colors.black, width: 5))),
                  child: Text(
                    'HISTORIAL DE SERVICIOS',
                    style: TextStyle(fontSize: 20, color: Colors.black),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
///////////////////////fin boton historial de servicios/////////////////////////////
////////////////////////////Termino boton Reporte de instalacion/////////////////////////
              ////////////////espaciado entre botones///////////////////////////////////////////////////
              SizedBox(
                height: 50,
              ),

////////////////////termino Espaciado entre botones////////////////////////////////////
              ///
/////////////////////boton REGRESAR //////////////////////////////////////////////
              Container(
                width: 200,
                height: 90,
                child: ElevatedButton(
                  onPressed: () {
                    // Acción a realizar cuando se presiona el botón
                  },
                  style: ElevatedButton.styleFrom(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      backgroundColor: Color.fromARGB(255, 250, 2, 2),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: BorderSide(color: Colors.black, width: 5))),
                  child: Text(
                    'REGRESAR',
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
        bottomNavigationBar: BottomAppBar(
          color: Color.fromARGB(255, 29, 29, 27),
          shape: CircularNotchedRectangle(),
          child: Container(
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