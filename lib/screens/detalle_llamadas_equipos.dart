import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:proyecto_qr/screens/llamadas_servicio_equipos.dart';

class DetallesLlamadaServicioEquipos extends StatefulWidget {
  final String ot;

  DetallesLlamadaServicioEquipos({required this.ot});

  @override
  _DetallesLlamadaServicioEquiposState createState() =>
      _DetallesLlamadaServicioEquiposState();
}

class _DetallesLlamadaServicioEquiposState
    extends State<DetallesLlamadaServicioEquipos> {
  Map<String, dynamic>? detallesOT; // Almacena los detalles de la OT

  @override
  void initState() {
    super.initState();
    // Realizar una consulta a la API para obtener los detalles de la OT
    _fetchOTDetails(widget.ot);
  }

  Future<void> _fetchOTDetails(String ot) async {
    final apiUrl =
        Uri.parse('http://192.168.1.160:5000/llamadas_de_servicio/ot/$ot');

    try {
      final response = await http.get(apiUrl);

      if (response.statusCode == 200) {
        final decodedResponse = json.decode(response.body);
        setState(() {
          detallesOT = decodedResponse;
        });
      } else {
        throw Exception('Error en la solicitud: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Widget _buildDetailCard(String label, String value) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 5),
            TextField(
              controller: TextEditingController(text: value),
              readOnly: true,
              maxLines: label == 'TRABAJO REALIZADO' ? 2 : 1,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(10),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
          ],
        ),
      ),
    );
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
        body: detallesOT != null
            ? SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Text(
                          'DETALLE DE OT',
                          style: TextStyle(fontSize: 40),
                        ),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Text(
                        'Número de OT: ${widget.ot}',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 20),
                      _buildDetailCard('FALLA', detallesOT?['FALLA'] ?? ''),
                      _buildDetailCard('HORÓMETRO', detallesOT!['HOROMETRO']),
                      _buildDetailCard('PERSONA QUE REPORTA',
                          detallesOT!['PERSONA QUE REPORTA']),
                      _buildDetailCard('TÉCNICO', detallesOT!['TECNICO']),
                      _buildDetailCard(
                          'TIPO DE SERVICIO', detallesOT!['TIPO DE SERVICIO']),
                      _buildDetailCard('TRABAJO REALIZADO',
                          detallesOT!['TRABAJO REALIZADO']),
                      SizedBox(
                        height: 20,
                      ),
                      Center(
                        child: SizedBox(
                          width: 200,
                          height: 90,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const LlamadaServiciosEquipos(),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              backgroundColor:
                                  const Color.fromARGB(255, 250, 2, 2),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                                side: const BorderSide(
                                    color: Colors.black, width: 5),
                              ),
                            ),
                            child: const Text(
                              'REGRESAR',
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            : Center(
                child: CircularProgressIndicator(),
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
}
