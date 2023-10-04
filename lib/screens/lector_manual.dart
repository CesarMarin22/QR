import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:proyecto_qr/providers/serial_number.dart';
import 'package:proyecto_qr/screens/escoger.dart';
import 'dart:convert';
import 'package:proyecto_qr/screens/menu_baterias.dart';
import 'package:proyecto_qr/screens/menu_cargadores.dart';
import 'package:proyecto_qr/screens/menu_equipos.dart';

class ManualInputPage extends StatefulWidget {
  const ManualInputPage({Key? key}) : super(key: key);

  @override
  _ManualInputPageState createState() => _ManualInputPageState();
}

class _ManualInputPageState extends State<ManualInputPage> {
  final TextEditingController serialNumberController = TextEditingController();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 0),
                child: Text(
                  'INTRODUCIR NUMERO DE SERIE',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(
                height: 70,
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextField(
                  controller: serialNumberController,
                  decoration: InputDecoration(
                    labelText: 'Número de Serie',
                    labelStyle:
                        TextStyle(color: Color.fromARGB(255, 243, 138, 0)),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color.fromARGB(255, 29, 29, 27),
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color.fromARGB(255, 29, 29, 27),
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 35),
              SizedBox(
                width: 200,
                height: 90,
                child: ElevatedButton(
                  onPressed: () async {
                    final numeroSerie = serialNumberController.text;
                    Provider.of<SerialNumberModel>(context, listen: false)
                        .setSerialNumber(numeroSerie);
                    await _fetchDataFromAPI(context, numeroSerie);
                  },
                  style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      backgroundColor: const Color.fromARGB(255, 250, 2, 2),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side:
                              const BorderSide(color: Colors.black, width: 5))),
                  child: Text('BUSCAR'),
                ),
              ),
              SizedBox(
                height: 35,
              ),
              SizedBox(
                width: 200,
                height: 90,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const eleccion()));
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
                    'SCANEAR',
                    style: TextStyle(fontSize: 20, color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ),
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
        ));
  }

  Future<void> _fetchDataFromAPI(BuildContext context, String numSerie) async {
    try {
      final endpoints = ['equipos', 'baterias', 'cargadores'];

      String grupoEncontrado = '';

      for (var endpoint in endpoints) {
        final response = await http.get(
          Uri.parse('http://192.168.1.160:5000/$endpoint/$numSerie'),
          headers: {
            'Content-Type': 'application/json',
          },
        );

        if (response.statusCode == 200) {
          final responseData = utf8.decode(response.bodyBytes);
          final decodedResponse = json.decode(responseData);
          if (decodedResponse != null && decodedResponse["SERIE"] == numSerie) {
            grupoEncontrado = decodedResponse["GRUPO"];
          }
          if (grupoEncontrado.isNotEmpty) {
            break;
          }
        }
      }

      if (grupoEncontrado.isNotEmpty) {
        if (grupoEncontrado == 'CARGADORES') {
          Navigator.push(
              context, MaterialPageRoute(builder: (_) => menuCargadores()));
        } else if (grupoEncontrado == 'MONTACARGAS') {
          Navigator.push(
              context, MaterialPageRoute(builder: (_) => menuEquipos()));
        } else if (grupoEncontrado == 'BATERIAS') {
          Navigator.push(
              context, MaterialPageRoute(builder: (_) => menuBaterias()));
        }
      } else {
        print('Número de serie no encontrado');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  void dispose() {
    serialNumberController.dispose();
    super.dispose();
  }
}
