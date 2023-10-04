import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_qr/providers/serial_number.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:proyecto_qr/screens/menu_cargadores.dart';
import 'package:proyecto_qr/screens/menu_equipos.dart';

class informacionCargadores extends StatefulWidget {
  @override
  _informacionCargadores createState() => _informacionCargadores();
}

class _informacionCargadores extends State<informacionCargadores> {
  TextEditingController _serieController = TextEditingController();
  TextEditingController _marcaController = TextEditingController();
  TextEditingController _modeloController = TextEditingController();
  TextEditingController _voltajeController = TextEditingController();
  TextEditingController _amperajeController = TextEditingController();
  TextEditingController _fechaImportacionController = TextEditingController();
  TextEditingController _comentariosController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final numSerie =
        Provider.of<SerialNumberModel>(context, listen: false).serialNumber;
    if (numSerie.isNotEmpty) {
      fetchDataFromAPI(numSerie);
    }
  }

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
        body: SingleChildScrollView(
          // Agregamos SingleChildScrollView aquí
          child: Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 30),
              child: Column(
                children: [
                  const Text(
                    'INFORMACIÓN DE CARGADORES',
                    style: TextStyle(fontSize: 25),
                  ),
                  const SizedBox(
                    height: 70,
                  ),
                  TextField(
                    controller: _serieController,
                    decoration: InputDecoration(
                      labelText: 'Serie',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    readOnly: true,
                  ),
                  SizedBox(height: 18.0), // Espaciado entre TextField
                  TextField(
                    controller: _marcaController,
                    decoration: InputDecoration(
                      labelText: 'Marca',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    readOnly: true,
                  ),
                  SizedBox(height: 18.0), // Espaciado entre TextField
                  TextField(
                    controller: _modeloController,
                    decoration: InputDecoration(
                      labelText: 'Modelo',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    readOnly: true,
                  ),
                  SizedBox(height: 18.0), // Espaciado entre TextField
                  TextField(
                    controller: _voltajeController,
                    decoration: InputDecoration(
                      labelText: 'Voltaje',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    readOnly: true,
                  ),
                  SizedBox(height: 18.0), // Espaciado entre TextField
                  TextField(
                    controller: _amperajeController,
                    decoration: InputDecoration(
                      labelText: 'Amperaje',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    readOnly: true,
                  ),
                  SizedBox(height: 18.0), // Espaciado entre TextField
                  TextField(
                    controller: _fechaImportacionController,
                    decoration: InputDecoration(
                      labelText: 'Fecha de Importación',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    readOnly: true,
                  ),
                  SizedBox(height: 18.0), // Espaciado entre TextField
                  TextField(
                    controller: _comentariosController,
                    decoration: InputDecoration(
                      labelText: 'Comentarios',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    readOnly: true,
                  ),
                  SizedBox(height: 18.0),
                  SizedBox(
                    width: 200,
                    height: 90,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const menuCargadores()));
                      },
                      style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
                          backgroundColor: const Color.fromARGB(255, 250, 2, 2),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                              side: const BorderSide(
                                  color: Colors.black, width: 5))),
                      child: const Text(
                        'REGRESAR',
                        style: TextStyle(fontSize: 20, color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  // Espaciado entre TextField
                ],
              ),
            ),
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

  Future<void> fetchDataFromAPI(String numSerie) async {
    final apiUrl = Uri.parse(
        'http://192.168.1.160:5000/cargadores/$numSerie'); // Reemplaza con la URL y el endpoint correctos

    try {
      final response = await http.get(apiUrl);

      if (response.statusCode == 200) {
        final decodedResponse = json.decode(response.body);

        setState(() {
          _serieController.text = decodedResponse['SERIE'] ?? '';
          _marcaController.text = decodedResponse['MARCA'] ?? '';
          _modeloController.text = decodedResponse['MODELO'] ?? '';
          _voltajeController.text =
              (decodedResponse['VOLTAJE'] ?? 0).toString();
          _amperajeController.text = decodedResponse['AMPERAJE'] ?? '';
          _fechaImportacionController.text =
              decodedResponse['FECHA_DE_IMPORTACION'] ?? '';
          _comentariosController.text = decodedResponse['COMENTARIOS'] ?? '';
        });
      } else {
        print('Error en la solicitud: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }
}
