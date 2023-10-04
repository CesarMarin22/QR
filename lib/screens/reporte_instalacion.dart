import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:rive/rive.dart';

class PDFViewerFromAPI extends StatefulWidget {
  const PDFViewerFromAPI({super.key});

  @override
  _PDFViewerFromAPIState createState() => _PDFViewerFromAPIState();
}

class _PDFViewerFromAPIState extends State<PDFViewerFromAPI> {
  final String _pdfUrl =
      'https://www.ibm.com/downloads/cas/GJ5QVQ7X'; // URL de la API que devuelve el PDF
  String? _localFilePath;

  @override
  void initState() {
    super.initState();
    _loadPDF();
  }

  Future<void> _loadPDF() async {
    try {
      final response = await http.get(Uri.parse(_pdfUrl));
      if (response.statusCode == 200) {
        final dir = await getTemporaryDirectory();
        final pdfFile = File('${dir.path}/temp.pdf');
        await pdfFile.writeAsBytes(response.bodyBytes);
        setState(() {
          _localFilePath = pdfFile.path;
        });
      } else {
        throw Exception('Error loading PDF');
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(65),
        child: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: const Color.fromARGB(255, 243, 138, 0),
          title: Center(
            child: Image.asset(
              'assets/logo_ipl_negro.png',
              width: 63,
              height: 63,
            ),
          ),
        ),
      ),
      body: _localFilePath != null
          ? PDFView(
              filePath: _localFilePath!,
            )
          : Container(
              color: Colors.white,
              child: Center(
                child: RiveAnimation.asset(
                  'assets/cargando_imagen.riv',
                  fit: BoxFit.cover,
                  alignment: Alignment.center,
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
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pop(context);
        },
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
        child: const Icon(Icons.arrow_back),
      ),
    );
  }
}
