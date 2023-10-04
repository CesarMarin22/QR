import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:proyecto_qr/providers/serial_number.dart';
import 'package:provider/provider.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:proyecto_qr/screens/detalle_llamadas_equipos.dart';

Color especialColor = Color(0xFFA9DFBF);
Color correctivoColor = Color(0xFFFAD02E);
Color preventivoColor = Color(0xFFE8DAEF);
Color azulPastel = Color(0xFFADD8E6);
Color rojopastel = Color(0xFFFFB6C1);

class LlamadaServiciosEquipos extends StatefulWidget {
  const LlamadaServiciosEquipos({Key? key});

  @override
  State<LlamadaServiciosEquipos> createState() =>
      _LlamadaServiciosEquiposState();
}

class _LlamadaServiciosEquiposState extends State<LlamadaServiciosEquipos> {
  bool isOption1Selected = true;
  Future<List<LlamadaServicio>>? futureCalls;
  String? selectedOT;
  int touchedIndex = -1;
  Map<String, int> serviceTypeCounts = {};

  @override
  void initState() {
    super.initState();
    final numSerie =
        Provider.of<SerialNumberModel>(context, listen: false).serialNumber;
    futureCalls = fetchCalls(numSerie);
    isOption1Selected =
        true; // Selecciona la primera opción (información) por defecto
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
                      FaIcon(FontAwesomeIcons.table),
                      Icon(Icons.pie_chart),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 60),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: FutureBuilder<List<LlamadaServicio>>(
                  future: futureCalls,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return Center(
                          child:
                              Text('No se encontraron llamadas de servicio.'));
                    } else if (isOption1Selected) {
                      return DataTable(
                        columns: <DataColumn>[
                          DataColumn(label: Text('O.T.')),
                          DataColumn(label: Text('FALLA')),
                          DataColumn(label: Text('FECHA')),
                          DataColumn(label: Text('TIPO DE SERVICIO')),
                        ],
                        rows: snapshot.data!
                            .map((llamada) => DataRow(
                                  cells: [
                                    DataCell(
                                      Text(llamada.ot),
                                      onTap: () {
                                        setState(() {
                                          selectedOT = llamada.ot;
                                        });
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                DetallesLlamadaServicioEquipos(
                                              ot: llamada.ot,
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                    DataCell(Text(llamada.falla)),
                                    DataCell(Text(llamada.fecha)),
                                    DataCell(Text(llamada.tipoServicio)),
                                  ],
                                ))
                            .toList(),
                      );
                    } else {
                      return PieChartSample2(
                        touchedIndex: touchedIndex,
                        llamadas: snapshot.data!,
                      );
                    }
                  },
                ),
              ),
            ),
          ),
        ],
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
      ),
    );
  }

  Widget _buildIndicators(List<LlamadaServicio> llamadas) {
    final Map<String, int> serviceTypeCounts = {};

    for (final llamada in llamadas) {
      final tipoServicio = llamada.tipoServicio;
      serviceTypeCounts[tipoServicio] =
          (serviceTypeCounts[tipoServicio] ?? 0) + 1;
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: serviceTypeCounts.entries.map((entry) {
        return _buildIndicator(getColorForServiceType(entry.key), entry.key);
      }).toList(),
    );
  }

  Widget _buildIndicator(Color color, String text) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          width: 16,
          height: 16,
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: color,
          ),
        ),
        SizedBox(width: 8),
        Text(text),
      ],
    );
  }

  List<PieChartSectionData> _generatePieChartSections(
    List<LlamadaServicio> llamadas,
  ) {
    final Map<String, int> serviceTypeCounts = {};

    for (final llamada in llamadas) {
      final tipoServicio = llamada.tipoServicio;
      serviceTypeCounts[tipoServicio] =
          (serviceTypeCounts[tipoServicio] ?? 0) + 1;
    }

    final List<PieChartSectionData> sections = [];

    serviceTypeCounts.entries.forEach((entry) {
      final String tipoServicio = entry.key;
      final int cantidad = entry.value;
      final double porcentaje = (cantidad / llamadas.length) * 100;

      final String label =
          '(${cantidad.toString()})\n${porcentaje.toStringAsFixed(2)}%';

      final PieChartSectionData section = PieChartSectionData(
        color: getColorForServiceType(tipoServicio),
        value: cantidad.toDouble(),
        title: label,
        radius: 150,
        titleStyle: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      );

      sections.add(section);
    });

    return sections;
  }

  Color getColorForServiceType(String tipoServicio) {
    Map<String, Color> colorMap = {
      'ESPECIAL': especialColor,
      'CORRECTIVO': correctivoColor,
      'PREVENTIVO': preventivoColor,
      'DAÑO': azulPastel,
      'DIAGNOSTICO': rojopastel,
    };

    return colorMap[tipoServicio] ?? Colors.grey;
  }

  Future<List<LlamadaServicio>> fetchCalls(String numSerie) async {
    final apiUrl =
        Uri.parse('http://192.168.1.160:5000/llamadas_de_servicio/$numSerie');

    try {
      final response = await http.get(apiUrl);

      if (response.statusCode == 200) {
        final List<dynamic> decodedResponse = json.decode(response.body);

        final List<LlamadaServicio> llamadas = decodedResponse
            .map((dynamic json) => LlamadaServicio.fromJson(json))
            .toList();

        return llamadas;
      } else {
        throw Exception('Error en la solicitud: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}

class LlamadaServicio {
  final String ot;
  final String falla;
  final String fecha;
  final String tipoServicio;

  LlamadaServicio({
    required this.ot,
    required this.falla,
    required this.fecha,
    required this.tipoServicio,
  });

  factory LlamadaServicio.fromJson(Map<String, dynamic> json) {
    return LlamadaServicio(
      ot: json['OT'] ?? '',
      falla: json['FALLA'] ?? '',
      fecha: json['FECHA'] ?? '',
      tipoServicio: json['TIPO DE SERVICIO'] ?? '',
    );
  }
}

class PieChartSample2 extends StatelessWidget {
  final int touchedIndex;
  final List<LlamadaServicio> llamadas;

  const PieChartSample2({
    required this.touchedIndex,
    required this.llamadas,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: 300,
          height: 300,
          child: Center(
            child: PieChart(
              PieChartData(
                centerSpaceRadius: 0,
                sectionsSpace: 4,
                borderData: FlBorderData(show: false),
                sections: [
                  ...showingSections(llamadas),
                  ..._generatePieChartSections(llamadas)
                ],
              ),
            ),
          ),
        ),
        SizedBox(
          height: 30,
        ),
        _buildIndicators(llamadas),
      ],
    );
  }

  List<PieChartSectionData> showingSections(List<LlamadaServicio> llamadas) {
    final List<PieChartSectionData> sections = [];
    final Map<String, int> serviceTypeCounts = {};

    // Calcular porcentajes fuera del bucle
    final Map<String, double> porcentajes = {};

    serviceTypeCounts.entries.forEach((entry) {
      final String tipoServicio = entry.key;
      final int cantidad = entry.value;
      final double porcentaje = (cantidad / llamadas.length) * 100;
      porcentajes[tipoServicio] = porcentaje;
    });

    // Usar porcentajes dentro del bucle para crear las secciones
    llamadas.forEach((llamada) {
      final isTouched = llamadas.indexOf(llamada) == touchedIndex;
      final fontSize = isTouched ? 25.0 : 16.0;
      final radius = isTouched ? 60.0 : 50.0;
      const shadows = [Shadow(color: Colors.black, blurRadius: 2)];

      final double porcentaje = porcentajes[llamada.tipoServicio] ?? 0.0;

      sections.add(
        PieChartSectionData(
          color: getColorForServiceType(llamada.tipoServicio),
          value: porcentaje, // Utiliza el porcentaje calculado previamente
          title: '${llamada.tipoServicio}\n${porcentaje.toStringAsFixed(2)}%',
          radius: radius,
          titleStyle: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
            color:
                Colors.white, // Cambia a blanco para que el texto sea visible
            shadows: shadows,
          ),
        ),
      );
    });

    return sections;
  }

  Widget _buildIndicators(List<LlamadaServicio> llamadas) {
    final Map<String, int> serviceTypeCounts = {};

    for (final llamada in llamadas) {
      final tipoServicio = llamada.tipoServicio;
      serviceTypeCounts[tipoServicio] =
          (serviceTypeCounts[tipoServicio] ?? 0) + 1;
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: serviceTypeCounts.entries.map((entry) {
        return _buildIndicator(getColorForServiceType(entry.key), entry.key);
      }).toList(),
    );
  }

  Widget _buildIndicator(Color color, String text) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          width: 16,
          height: 16,
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: color,
          ),
        ),
        SizedBox(width: 8),
        Text(text),
      ],
    );
  }

  List<PieChartSectionData> _generatePieChartSections(
    List<LlamadaServicio> llamadas,
  ) {
    final Map<String, int> serviceTypeCounts = {};

    for (final llamada in llamadas) {
      final tipoServicio = llamada.tipoServicio;
      serviceTypeCounts[tipoServicio] =
          (serviceTypeCounts[tipoServicio] ?? 0) + 1;
    }

    final List<PieChartSectionData> sections = [];

    serviceTypeCounts.entries.forEach((entry) {
      final String tipoServicio = entry.key;
      final int cantidad = entry.value;
      final double porcentaje = (cantidad / llamadas.length) * 100;

      final String label =
          '(${cantidad.toString()})\n${porcentaje.toStringAsFixed(2)}%';

      final PieChartSectionData section = PieChartSectionData(
        color: getColorForServiceType(tipoServicio),
        value: cantidad.toDouble(),
        title: label,
        radius: 150,
        titleStyle: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      );

      sections.add(section);
    });

    return sections;
  }

  Color getColorForServiceType(String tipoServicio) {
    Map<String, Color> colorMap = {
      'ESPECIAL': especialColor,
      'CORRECTIVO': correctivoColor,
      'PREVENTIVO': preventivoColor,
      'DAÑO': azulPastel,
      'DIAGNOSTICO': rojopastel,
    };

    return colorMap[tipoServicio] ?? Colors.grey;
  }
}
