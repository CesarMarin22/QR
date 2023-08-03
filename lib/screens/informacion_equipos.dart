// import 'package:flutter/material.dart';

// class informacionEquipos extends StatefulWidget {
//   const informacionEquipos({super.key});

//   @override
//   State<informacionEquipos> createState() => _informacionEquiposState();
// }

// class _informacionEquiposState extends State<informacionEquipos> {
//   final Map<String, String> valuesFromServiceLayer = {
//     'SERIE': 'Valor de Serie',
//     'MARCA': 'Valor de Marca',
//     'MODELO': 'Valor de Modelo',
//     'TIPO': 'Valor de Tipo',
//     'VOLTAJE': 'Valor de Voltaje',
//     'CAPACIDAD': 'Valor de Capacidad',
//     'ALTURA DE ESTIBA': 'Valor de Altura de Estiba',
//     'ADITAMENTO': 'Valor de Aditamento',
//     'FECHA DE IMPORTACIÓN': 'Valor de Fecha de Importación',
//     'COMENTARIOS': 'Valor de Comentarios',
//   };

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Text Boxes'),
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: EdgeInsets.all(15),
//           child: Column(
//             children: <Widget>[
//               MyTextBox(label: 'SERIE', initialValue: valuesFromServiceLayer['SERIE']),
//               MyTextBox(label: 'MARCA', initialValue: valuesFromServiceLayer['MARCA']),
//               MyTextBox(label: 'MODELO', initialValue: valuesFromServiceLayer['MODELO']),
//               MyTextBox(label: 'TIPO', initialValue: valuesFromServiceLayer['TIPO']),
//               MyTextBox(label: 'VOLTAJE', initialValue: valuesFromServiceLayer['VOLTAJE']),
//               MyTextBox(label: 'CAPACIDAD', initialValue: valuesFromServiceLayer['CAPACIDAD']),
//               MyTextBox(label: 'ALTURA DE ESTIBA', initialValue: valuesFromServiceLayer['ALTURA DE ESTIBA']),
//               MyTextBox(label: 'ADITAMENTO', initialValue: valuesFromServiceLayer['ADITAMENTO']),
//               MyTextBox(label: 'FECHA DE IMPORTACIÓN', initialValue: valuesFromServiceLayer['FECHA DE IMPORTACIÓN']),
//               MyTextBox(label: 'COMENTARIOS', initialValue: valuesFromServiceLayer['COMENTARIOS']),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class MyTextBox extends StatelessWidget {
//   final String label;
//   final String initialValue;

//   const MyTextBox({required this.label, required this.initialValue});

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.all(15),
//       child: TextField(
//         readOnly: true,
//         controller: TextEditingController(text: initialValue), // Establecer el valor inicial del TextField
//         decoration: InputDecoration(
//           border: OutlineInputBorder(),
//           labelText: label,
//         ),
//       ),
//     );
//     );
//   }
// }

// class textBoxEquipos extends StatelessWidget {
//   final String label;

//   const textBoxEquipos({required this.label});

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.all(15),
//       child: TextField(
//         readOnly: true,
//         decoration: InputDecoration(
//           border: OutlineInputBorder(),
//           labelText: label,
//         ),
//       ),
//     );
//   }
// }
