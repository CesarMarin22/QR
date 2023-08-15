import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SapB1ServiceTester {
  final String baseUrl = 'https://104.215.119.168:50000'; // URL sin el puerto
  final int port = 50000; // Puerto que deseas agregar
  final String companyDB = 'B1_IPL_T5';
  final String userName = 'manager';
  final String password = 'IPL_Sir17';

  Future<void> testConnection(BuildContext context) async {
    bool isConnected = await _connectToServiceLayer();

    if (isConnected) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('¡Conexión exitosa a Service Layer!'),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('¡La conexión falló!'),
        ),
      );
    }
  }

  Future<bool> _connectToServiceLayer() async {
    // final url =
    //     Uri.parse('$baseUrl:$port/b1s/v1/Login'); // Agregar el puerto a la URL
    // final response = await http.post(
    //   url,
    //   headers: {
    //     'Content-Type': 'text/plain',
    //     'Accept': '*/*',
    //     'Accept-Encoding': 'gzip, deflate, br',
    //     'Connection': 'keep-alive',
    //     'Secure': 'false',
    //   },
    //   body: '''
    //     {
    //       "CompanyDB": "$companyDB",
    //       "UserName": "$userName",
    //       "Password": "$password"
    //     }
    //   ''',
    // );
    try {
      HttpClient httpClient = new HttpClient();
      httpClient.badCertificateCallback =
          (X509Certificate cert, String host, int port) {
        return true;
      };
      var url = "https://104.215.119.168:50000/b1s/v1/Login";
      HttpClientRequest request = await httpClient.postUrl(Uri.parse(url));
      HttpClientResponse response = await request.close();
      String responseBody = await response.transform(utf8.decoder).join();
      if (response.statusCode == HttpStatus.ok) {
        print('success');
        print(response.headers);
        print(responseBody);
      }
    } catch (e) {
      print("fail：$e");
    }
    return true;
    //return response.statusCode == 200;
  }
}

class MyWidget extends StatelessWidget {
  final SapB1ServiceTester _tester = SapB1ServiceTester();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Service Layer Connection Tester'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () => _tester.testConnection(context),
          child: Text('Test Connection to Service Layer'),
        ),
      ),
    );
  }
}
