import 'package:flutter/material.dart';
import 'package:proyecto_qr/screens/menu_baterias.dart';
import 'package:proyecto_qr/screens/menu_cargadores.dart';
import 'package:proyecto_qr/screens/menu_equipos.dart';

class InputPage extends StatefulWidget {
  @override
  _InputPageState createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  final TextEditingController articleController = TextEditingController();
  final TextEditingController serialNumberController = TextEditingController();
  String errorTextArticle = '';
  bool botonHabilitado = false;

  @override
  void dispose() {
    articleController.dispose();
    serialNumberController.dispose();
    super.dispose();
  }

  void navigateTomenuEquipos() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => menuEquipos()),
    ).then((_) {
      articleController.clear();
      serialNumberController.clear();
      setState(() {
        errorTextArticle = '';
        botonHabilitado = false;
      });
    });
  }

  void navigateTomenuBaterias() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => menuBaterias()),
    ).then((_) {
      articleController.clear();
      serialNumberController.clear();
      setState(() {
        errorTextArticle = '';
        botonHabilitado = false;
      });
    });
  }

  void navigateTomenuCargadores() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => menuCargadores()),
    ).then((_) {
      articleController.clear();
      serialNumberController.clear();
      setState(() {
        errorTextArticle = '';
        botonHabilitado = false;
      });
    });
  }

  void mostrarErrorArticulo() {
    setState(() {
      errorTextArticle = 'Articulo no valido';
      botonHabilitado = false;
    });
  }

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
        body: Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 30),
            child: Column(
              children: [
                TextField(
                  controller: articleController,
                  onChanged: (value) {
                    setState(() {
                      errorTextArticle = '';
                      if (value.isNotEmpty &&
                          serialNumberController.text.isNotEmpty) {
                        botonHabilitado = true;
                      } else {
                        botonHabilitado = false;
                      }
                    });
                  },
                  decoration: InputDecoration(
                    labelText: 'Artículo',
                    errorText: errorTextArticle,
                  ),
                ),
                TextField(
                  controller: serialNumberController,
                  onChanged: (value) {
                    setState(() {
                      if (value.isNotEmpty &&
                          articleController.text.isNotEmpty) {
                        botonHabilitado = true;
                      } else {
                        botonHabilitado = false;
                      }
                    });
                  },
                  decoration: InputDecoration(
                    labelText: 'Número de Serie',
                  ),
                ),
                SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: botonHabilitado
                      ? () {
                          String article = articleController.text;

                          errorTextArticle = '';
                          switch (article.substring(0, 2)) {
                            case 'ME':
                              // Mostrar pantalla A
                              navigateTomenuEquipos();
                              break;
                            case 'MC':
                              navigateTomenuEquipos();
                              break;
                            case 'MH':
                              navigateTomenuEquipos();
                              break;
                            case 'SM':
                              navigateTomenuEquipos();
                              break;
                            case 'VE':
                              navigateTomenuEquipos();
                              break;
                            case 'PE':
                              navigateTomenuEquipos();
                              break;
                            case 'CE':
                              navigateTomenuEquipos();
                              break;
                            case 'TE':
                              navigateTomenuEquipos();
                              break;
                            case 'RE':
                              navigateTomenuEquipos();
                              break;
                            case 'BP':
                              navigateTomenuBaterias();
                              break;
                            case 'BL':
                              navigateTomenuBaterias();
                              break;
                            case 'C1':
                              navigateTomenuBaterias();
                              break;
                            case 'C2':
                              navigateTomenuBaterias();
                              break;
                            case 'C3':
                              navigateTomenuBaterias();
                              break;
                            case 'C4':
                              navigateTomenuBaterias();
                              break;
                            case 'C7':
                              navigateTomenuBaterias();
                              break;
                            case 'C8':
                              navigateTomenuBaterias();
                              break;
                            case 'C9':
                              navigateTomenuBaterias();
                              break;
                            case 'S1':
                              navigateTomenuBaterias();
                              break;
                            case 'S2':
                              navigateTomenuBaterias();
                              break;
                            case 'S3':
                              navigateTomenuBaterias();
                              break;
                            case 'S4':
                              navigateTomenuBaterias();
                              break;
                            case 'S7':
                              navigateTomenuBaterias();
                              break;
                            case 'S8':
                              navigateTomenuBaterias();
                              break;
                            case 'S9':
                              navigateTomenuBaterias();
                              break;
                            case 'BF':
                              navigateTomenuBaterias();
                              break;
                            case 'PP':
                              navigateTomenuCargadores();
                              break;
                            case 'PL':
                              navigateTomenuCargadores();
                              break;
                            case 'PF':
                              navigateTomenuCargadores();
                              break;
                            // Agrega más casos según tus necesidades
                            default:
                              mostrarErrorArticulo();
                              break;
                          }
                        }
                      : null,
                  child: Text('Verificar'),
                ),
              ],
            ),
          ),
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
}
