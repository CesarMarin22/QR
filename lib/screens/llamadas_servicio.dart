import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:proyecto_qr/screens/escoger.dart';
import 'package:proyecto_qr/screens/informacion_equipos.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:proyecto_qr/screens/reporte_instalacion.dart';
import 'package:http/http.dart' as http;
import 'package:proyecto_qr/screens/app_data.dart';

class llamadaServicios extends StatefulWidget {
  const llamadaServicios({super.key});

  @override
  State<llamadaServicios> createState() => _llamadaServicios();
}

class _llamadaServicios extends State<llamadaServicios> {
  bool isOption1Selected = true;
  List<Map<String, dynamic>> apiData = [];
  @override
  @override
  void initState() {
    super.initState();
    // Llama a la función para obtener datos de la API al cargar la pantalla
    fetchDataFromAPI();
  }

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
        body: Column(
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 30),
                child: Column(
                  children: [
                    const Text(
                      'HISTORIAL DE SERVICIOS',
                      style: TextStyle(fontSize: 30),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    ToggleButtons(
                      selectedColor: Colors.white,
                      fillColor: Color.fromARGB(255, 243, 138, 0),
                      borderWidth: 3,
                      selectedBorderColor: Color.fromARGB(255, 243, 138, 0),
                      borderRadius: BorderRadius.circular(50),
                      isSelected: [isOption1Selected, !isOption1Selected],
                      onPressed: (index) {
                        setState(() {
                          isOption1Selected = index == 0;
                        });
                      },
                      children: [
                        Icon(Icons.info),
                        Icon(Icons.pie_chart),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            Container(
              child: isOption1Selected
                  ? Text('Contenido de la Opción 1')
                  : Text('Contenido de la Opción 2'),
            ),
          ],
        ),

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

  Future<void> fetchDataFromAPI() async {
    try {
      final response = await http.get(Uri.parse(
          'http://localhost:5000/llamadas_de_servicio/${AppData().numSerie}'));
      if (response.statusCode == 200) {
        // Decodifica la respuesta JSON y almacena los datos en apiData
        setState(() {
          apiData = List<Map<String, dynamic>>.from(json.decode(response.body));
        });
      } else {
        throw Exception('Error al obtener datos de la API');
      }
    } catch (error) {
      print('Error: $error');
    }
  }
}
