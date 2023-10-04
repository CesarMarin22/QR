// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:provider/provider.dart';
// import 'package:proyecto_qr/providers/auth_provider.dart';
// import 'dart:convert';
// import 'package:qr_code_scanner/qr_code_scanner.dart';
// import 'package:proyecto_qr/screens/menu_baterias.dart';
// import 'package:proyecto_qr/screens/menu_cargadores.dart';
// import 'package:proyecto_qr/screens/menu_equipos.dart';
// import 'package:proyecto_qr/screens/sesion.dart';

// class QRScannerPage extends StatefulWidget {
//   @override
//   _QRScannerPageState createState() => _QRScannerPageState();
// }

// class _QRScannerPageState extends State<QRScannerPage> {
//   final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
//   QRViewController? controller;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Lector de QR'),
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             flex: 4,
//             child: QRView(
//               key: qrKey,
//               onQRViewCreated: _onQRViewCreated,
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   void _onQRViewCreated(QRViewController controller) {
//     this.controller = controller;
//     controller.scannedDataStream.listen((scanData) async {
//       final authProvider = Provider.of<AuthProvider>(context, listen: false);
//       // Cuando se escanea un código QR
//       controller.dispose(); // Detener la cámara

//       // Realizar solicitud a la API para obtener información
//       String numeroSerie = scanData.code.toString();
//       String token =
//           authProvider.token; // Reemplaza con tu token de autenticación

//       final response = await http.get(
//         Uri.parse('http://192.168.1.31:5000/equipos?numero_serie=$numeroSerie'),
//         headers: {'Authorization': 'Bearer $token'},
//       );
//       print('${response}');

//       if (response.statusCode == 200) {
//         final jsonData = json.decode(response.body);
//         String grupo = jsonData['GRUPO'];

//         // Abre la pantalla correspondiente según el grupo
//         _abrirPantalla(grupo);
//       } else {
//         // Manejar errores de solicitud API
//         print('Error al obtener datos de la API');
//         print('Error en la solicitud: ${response.statusCode}');
//       }
//     });
//   }

//   void _abrirPantalla(String grupo) {
//     // Aquí puedes navegar a la pantalla correspondiente según el grupo.
//     // Por ejemplo:
//     if (grupo == 'MONTACARGAS') {
//       Navigator.push(context, MaterialPageRoute(builder: (_) => menuEquipos()));
//     } else if (grupo == 'BATERIAS') {
//       Navigator.push(
//           context, MaterialPageRoute(builder: (_) => menuBaterias()));
//     } else if (grupo == 'CARGADORES') {
//       Navigator.push(
//           context, MaterialPageRoute(builder: (_) => menuCargadores()));
//     } else {
//       // Manejar caso desconocido
//       print('Grupo desconocido');
//     }
//   }

//   @override
//   void dispose() {
//     controller?.dispose();
//     super.dispose();
//   }
// }

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'dart:convert';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:proyecto_qr/screens/menu_baterias.dart';
import 'package:proyecto_qr/screens/menu_cargadores.dart';
import 'package:proyecto_qr/screens/menu_equipos.dart';
import 'package:proyecto_qr/providers/serial_number.dart';

class QRScannerPage extends StatefulWidget {
  const QRScannerPage({Key? key}) : super(key: key);

  @override
  _QRScannerPageState createState() => _QRScannerPageState();
}

class _QRScannerPageState extends State<QRScannerPage> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  late QRViewController controller;
  String numSerie = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('QR Scanner'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 5,
            child: Stack(
              alignment: Alignment.center,
              children: [
                QRView(
                  key: qrKey,
                  onQRViewCreated: _onQRViewCreated,
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.red,
                      width: 2,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Center(
              child:
                  numSerie.isEmpty ? Text('Escaneando...') : SizedBox.shrink(),
            ),
          ),
        ],
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        String qrCodeContent = scanData.code?.replaceAll('\n', '') ?? '';
        if (qrCodeContent.isNotEmpty) {
          numSerie = qrCodeContent;
          Provider.of<SerialNumberModel>(context, listen: false)
              .setSerialNumber(numSerie);
          _fetchDataFromAPI(numSerie);
        }
      });
    });
  }

  Future<void> _fetchDataFromAPI(String numSerie) async {
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

        print('${response.body}');

        if (response.statusCode == 200) {
          final responseData = utf8.decode(response.bodyBytes);
          final decodedResponse = json.decode(responseData);
          // Verificar si el campo "serie" coincide con el número de serie escaneado
          if (decodedResponse != null && decodedResponse["SERIE"] == numSerie) {
            grupoEncontrado = decodedResponse["GRUPO"];
            print('Tipo de Respuesta: ${responseData.runtimeType}');
          }
          // Si se encontró un grupo, salir del bucle
          if (grupoEncontrado.isNotEmpty) {
            break;
          }
        }
      }
      // Después de determinar el grupo, realizar la navegación
      if (grupoEncontrado.isNotEmpty) {
        // Navegar a la pantalla correspondiente según el grupo
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
        // Si no se encontró en ningún grupo, muestra un mensaje
        print('Número de serie no encontrado');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}




////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// import 'package:flutter/material.dart';
// import 'package:proyecto_qr/screens/app_data.dart';
// import 'package:proyecto_qr/screens/menu_baterias.dart';
// import 'package:proyecto_qr/screens/menu_cargadores.dart';
// import 'package:proyecto_qr/screens/menu_equipos.dart';
// import 'package:qr_code_scanner/qr_code_scanner.dart';

// class QRScannerPage extends StatefulWidget {
//   const QRScannerPage({super.key});

//   @override
//   _QRScannerPageState createState() => _QRScannerPageState();
// }

// class _QRScannerPageState extends State<QRScannerPage> {
//   final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
//   late QRViewController controller;
//   String articulo = '';
//   String numSerie = '';
//   bool scanning = true;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           backgroundColor: const Color.fromARGB(255, 243, 138, 0),
//           title: Center(
//             child: Image.asset(
//               'assets/logo_ipl_negro.png',
//               width: 70,
//               height: 70,
//             ),
//           ),
//         ),
//         body: Column(
//           children: <Widget>[
//             Expanded(
//               flex: 5,
//               child: Stack(
//                 alignment: Alignment.center,
//                 children: [
//                   QRView(
//                     key: qrKey,
//                     onQRViewCreated: _onQRViewCreated,
//                   ),
//                   Container(
//                     decoration: BoxDecoration(
//                       border: Border.all(
//                         color: Colors.red,
//                         width: 2,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             Expanded(
//               flex: 1,
//               child: Center(
//                 child: scanning
//                     ? const Text('Escaneando...')
//                     : const Column(
//                         children: [
//                           //Text('Articulo: $articulo'),
//                           //Text('Numero de Serie: $numSerie'),
//                         ],
//                       ),
//               ),
//             ),
//           ],
//         ),
//         bottomNavigationBar: const BottomAppBar(
//           color: Color.fromARGB(255, 29, 29, 27),
//           shape: CircularNotchedRectangle(),
//           child: SizedBox(
//             height: 50,
//             child: Center(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text(
//                     'Copyright ©2023, Todos los Derechos Reservados.',
//                     style: TextStyle(
//                         fontWeight: FontWeight.w300,
//                         fontSize: 12.0,
//                         color: Color.fromARGB(255, 255, 255, 255)),
//                   ),
//                   Text(
//                     'Powered by IPL',
//                     style: TextStyle(
//                         fontWeight: FontWeight.w300,
//                         fontSize: 12.0,
//                         color: Color.fromARGB(255, 255, 255, 255)),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ));
//   }

//   void _onQRViewCreated(QRViewController controller) {
//     this.controller = controller;
//     controller.scannedDataStream.listen((scanData) {
//       setState(() {
//         List<String> values = scanData.code?.split('\n') ?? [];
//         if (values.length >= 2) {
//           articulo = values[0];
//           AppData().numSerie = values[0];
//           // Aquí usamos switch para manejar diferentes casos
//           switch (articulo.substring(0, 2)) {
//             case 'ME':
//               // Mostrar pantalla A
//               Navigator.pushReplacement(
//                 context,
//                 MaterialPageRoute(builder: (context) => const menuEquipos()),
//               );
//               break;
//             case 'MC':
//               Navigator.pushReplacement(
//                 context,
//                 MaterialPageRoute(builder: (context) => const menuEquipos()),
//               );
//               break;
//             case 'MH':
//               Navigator.pushReplacement(
//                 context,
//                 MaterialPageRoute(builder: (context) => const menuEquipos()),
//               );
//               break;
//             case 'SM':
//               Navigator.pushReplacement(
//                 context,
//                 MaterialPageRoute(builder: (context) => const menuEquipos()),
//               );
//               break;
//             case 'VE':
//               Navigator.pushReplacement(
//                 context,
//                 MaterialPageRoute(builder: (context) => const menuEquipos()),
//               );
//               break;
//             case 'PE':
//               Navigator.pushReplacement(
//                 context,
//                 MaterialPageRoute(builder: (context) => const menuEquipos()),
//               );
//               break;
//             case 'CE':
//               Navigator.pushReplacement(
//                 context,
//                 MaterialPageRoute(builder: (context) => const menuEquipos()),
//               );
//               break;
//             case 'TE':
//               Navigator.pushReplacement(
//                 context,
//                 MaterialPageRoute(builder: (context) => const menuEquipos()),
//               );
//               break;
//             case 'RE':
//               Navigator.pushReplacement(
//                 context,
//                 MaterialPageRoute(builder: (context) => const menuEquipos()),
//               );
//               break;
//             case 'BP':
//               Navigator.pushReplacement(
//                 context,
//                 MaterialPageRoute(builder: (context) => const menuBaterias()),
//               );
//               break;
//             case 'BL':
//               Navigator.pushReplacement(
//                 context,
//                 MaterialPageRoute(builder: (context) => const menuBaterias()),
//               );
//               break;
//             case 'C1':
//               Navigator.pushReplacement(
//                 context,
//                 MaterialPageRoute(builder: (context) => const menuBaterias()),
//               );
//               break;
//             case 'C2':
//               Navigator.pushReplacement(
//                 context,
//                 MaterialPageRoute(builder: (context) => const menuBaterias()),
//               );
//               break;
//             case 'C3':
//               Navigator.pushReplacement(
//                 context,
//                 MaterialPageRoute(builder: (context) => const menuBaterias()),
//               );
//               break;
//             case 'C4':
//               Navigator.pushReplacement(
//                 context,
//                 MaterialPageRoute(builder: (context) => const menuBaterias()),
//               );
//               break;
//             case 'C7':
//               Navigator.pushReplacement(
//                 context,
//                 MaterialPageRoute(builder: (context) => const menuBaterias()),
//               );
//               break;
//             case 'C8':
//               Navigator.pushReplacement(
//                 context,
//                 MaterialPageRoute(builder: (context) => const menuBaterias()),
//               );
//               break;
//             case 'C9':
//               Navigator.pushReplacement(
//                 context,
//                 MaterialPageRoute(builder: (context) => const menuBaterias()),
//               );
//               break;
//             case 'S1':
//               Navigator.pushReplacement(
//                 context,
//                 MaterialPageRoute(builder: (context) => const menuBaterias()),
//               );
//               break;
//             case 'S2':
//               Navigator.pushReplacement(
//                 context,
//                 MaterialPageRoute(builder: (context) => const menuBaterias()),
//               );
//               break;
//             case 'S3':
//               Navigator.pushReplacement(
//                 context,
//                 MaterialPageRoute(builder: (context) => const menuBaterias()),
//               );
//               break;
//             case 'S4':
//               Navigator.pushReplacement(
//                 context,
//                 MaterialPageRoute(builder: (context) => const menuBaterias()),
//               );
//               break;
//             case 'S7':
//               Navigator.pushReplacement(
//                 context,
//                 MaterialPageRoute(builder: (context) => const menuBaterias()),
//               );
//               break;
//             case 'S8':
//               Navigator.pushReplacement(
//                 context,
//                 MaterialPageRoute(builder: (context) => const menuBaterias()),
//               );
//               break;
//             case 'S9':
//               Navigator.pushReplacement(
//                 context,
//                 MaterialPageRoute(builder: (context) => const menuBaterias()),
//               );
//               break;
//             case 'BF':
//               Navigator.pushReplacement(
//                 context,
//                 MaterialPageRoute(builder: (context) => const menuBaterias()),
//               );
//               break;
//             case 'PP':
//               Navigator.pushReplacement(
//                 context,
//                 MaterialPageRoute(builder: (context) => const menuCargadores()),
//               );
//               break;
//             case 'PL':
//               Navigator.pushReplacement(
//                 context,
//                 MaterialPageRoute(builder: (context) => const menuCargadores()),
//               );
//               break;
//             case 'PF':
//               Navigator.pushReplacement(
//                 context,
//                 MaterialPageRoute(builder: (context) => const menuCargadores()),
//               );
//               break;
//             // Agrega más casos según tus necesidades
//             default:
//               // Mostrar una pantalla de valor desconocido o manejar otro caso
//               break;
//           }
//         }
//         scanning = false;
//       });
//     });
//   }

//   @override
//   void dispose() {
//     controller.dispose();
//     super.dispose();
//   }
// }
