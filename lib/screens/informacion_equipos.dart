import 'package:flutter/material.dart';
import 'package:proyecto_qr/screens/menu_equipos.dart';

class InformacionEquipos {
  String serie = 'MC-12345';
  String marca = 'STILL';
  String modelo = 'RJ45';
  String tipo = 'ELECTRICO';
  String voltaje = '48V';
  String capacidad = '2000 KG';
  String alturaEstiba = '500 CM';
  String aditamento = 'HORQUILLAS AJUSTABLES';
  String fechaImportacion = '15/07/2023';
  String comentarios = 'EXCELENTE ESTADO, RECIÉN MANTENIDO';
}

class informacionEquipos extends StatefulWidget {
  @override
  _informacionEquipos createState() => _informacionEquipos();
}

class _informacionEquipos extends State<informacionEquipos> {
  final _formKey = GlobalKey<FormState>();
  InformacionEquipos _infoEquipos = InformacionEquipos();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(65),
          child: AppBar(
            backgroundColor: Color.fromARGB(255, 243, 138, 0),
            title: Center(
              child: Image.asset(
                'assets/logo_ipl_negro.png',
                width: 63,
                height: 63,
              ),
            ),
          ),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 30),
            child: ListView(
              children: [
                Text(
                  'INFORMACIÓN DE EQUIPOS',
                  style: TextStyle(
                    fontSize: 30,
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                _buildTextField('Serie', _infoEquipos.serie),
                SizedBox(height: 12),
                _buildTextField('Marca', _infoEquipos.marca),
                SizedBox(height: 12),
                _buildTextField('Modelo', _infoEquipos.modelo),
                SizedBox(height: 12),
                _buildTextField('Tipo', _infoEquipos.tipo),
                SizedBox(height: 12),
                _buildTextField('Voltaje', _infoEquipos.voltaje),
                SizedBox(height: 12),
                _buildTextField('Capacidad', _infoEquipos.capacidad),
                SizedBox(height: 12),
                _buildTextField('Altura de Estiba', _infoEquipos.alturaEstiba),
                SizedBox(height: 12),
                _buildTextField('Aditamento', _infoEquipos.aditamento),
                SizedBox(height: 12),
                _buildTextField(
                    'Fecha de Importación', _infoEquipos.fechaImportacion),
                SizedBox(height: 12),
                _buildTextField('Comentarios', _infoEquipos.comentarios),
                SizedBox(height: 40),
                Container(
                  width: 100,
                  height: 90,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => menuEquipos()));
                    },
                    style: ElevatedButton.styleFrom(
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        backgroundColor: Color.fromARGB(255, 250, 2, 2),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side: BorderSide(color: Colors.black, width: 5))),
                    child: Text(
                      'REGRESAR',
                      style: TextStyle(fontSize: 20, color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  ),
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

  Widget _buildTextField(String label, String value) {
    return TextFormField(
      initialValue: value,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Por favor ingresa $label';
        }
        return null;
      },
      onChanged: (newValue) {
        setState(() {
          switch (label) {
            case 'Serie':
              _infoEquipos.serie = newValue;
              break;
            case 'Marca':
              _infoEquipos.marca = newValue;
              break;
            // ... Repetir para los demás campos
          }
        });
      },
    );
  }
}
