import 'package:flutter/material.dart';
import 'package:proyecto_qr/screens/menu_baterias.dart';
import 'package:proyecto_qr/screens/menu_cargadores.dart';
import 'package:proyecto_qr/screens/menu_equipos.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QRScannerPage extends StatefulWidget {
  @override
  _QRScannerPageState createState() => _QRScannerPageState();
}

class _QRScannerPageState extends State<QRScannerPage> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  late QRViewController controller;
  String articulo = '';
  String numSerie = '';
  bool scanning = true;

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
                child: scanning
                    ? Text('Escaneando...')
                    : Column(
                        children: [
                          //Text('Articulo: $articulo'),
                          //Text('Numero de Serie: $numSerie'),
                        ],
                      ),
              ),
            ),
          ],
        ),
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
        ));
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        List<String> values = scanData.code?.split('\n') ?? [];
        if (values.length >= 2) {
          articulo = values[0];
          numSerie = values[0];
          // Aquí usamos switch para manejar diferentes casos
          switch (articulo.substring(0, 2)) {
            case 'ME':
              // Mostrar pantalla A
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => menuEquipos()),
              );
              break;
            case 'MC':
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => menuEquipos()),
              );
              break;
            case 'MH':
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => menuEquipos()),
              );
              break;
            case 'SM':
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => menuEquipos()),
              );
              break;
            case 'VE':
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => menuEquipos()),
              );
              break;
            case 'PE':
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => menuEquipos()),
              );
              break;
            case 'CE':
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => menuEquipos()),
              );
              break;
            case 'TE':
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => menuEquipos()),
              );
              break;
            case 'RE':
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => menuEquipos()),
              );
              break;
            case 'BP':
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => menuBaterias()),
              );
              break;
            case 'BL':
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => menuBaterias()),
              );
              break;
            case 'C1':
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => menuBaterias()),
              );
              break;
            case 'C2':
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => menuBaterias()),
              );
              break;
            case 'C3':
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => menuBaterias()),
              );
              break;
            case 'C4':
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => menuBaterias()),
              );
              break;
            case 'C7':
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => menuBaterias()),
              );
              break;
            case 'C8':
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => menuBaterias()),
              );
              break;
            case 'C9':
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => menuBaterias()),
              );
              break;
            case 'S1':
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => menuBaterias()),
              );
              break;
            case 'S2':
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => menuBaterias()),
              );
              break;
            case 'S3':
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => menuBaterias()),
              );
              break;
            case 'S4':
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => menuBaterias()),
              );
              break;
            case 'S7':
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => menuBaterias()),
              );
              break;
            case 'S8':
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => menuBaterias()),
              );
              break;
            case 'S9':
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => menuBaterias()),
              );
              break;
            case 'BF':
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => menuBaterias()),
              );
              break;
            case 'PP':
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => menuCargadores()),
              );
              break;
            case 'PL':
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => menuCargadores()),
              );
              break;
            case 'PF':
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => menuCargadores()),
              );
              break;
            // Agrega más casos según tus necesidades
            default:
              // Mostrar una pantalla de valor desconocido o manejar otro caso
              break;
          }
        }
        scanning = false;
      });
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
