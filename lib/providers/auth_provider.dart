import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:proyecto_qr/models/user.dart';

class AuthProvider with ChangeNotifier {
  final List<User> _localUsers = [
    User('admin', '12345'),
    User('usuario', '12345'),
    // Agrega más usuarios aquí
  ];

  User? _authenticatedUser;
  String? _cookie;
  String? get cookie => _cookie;
  User? get authenticatedUser => _authenticatedUser;

  Future<void> login(String username, String password) async {
    final localUser = _localUsers.firstWhere(
      (user) => user.username == username,
      orElse: () => User('', ''),
    );

    if (localUser.username.isEmpty) {
      throw UserNotFoundException('Usuario Incorrecto');
    }

    if (localUser.password != password) {
      throw InvalidCredentialsException('Contraseña Incorrecta');
    }

    // Realiza una solicitud de inicio de sesión a la API
    final apiLoginUrl = 'http://192.168.1.160:5000/login';
    final requestData = {
      'username': 'manager',
      'password': 'IPL_Sir17',
    };

    try {
      final loginResponse = await http.post(
        Uri.parse(apiLoginUrl),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(requestData),
      );

      if (loginResponse.statusCode == 200) {
        // Guarda la cookie en lugar de un token
        _cookie = loginResponse.headers['set-cookie'];
        // Aquí debes guardar y gestionar la cookie, por ejemplo, utilizando un paquete de manejo de cookies
        // o almacenándola en un lugar seguro para su uso posterior en las solicitudes.
        // _saveCookie(cookie);
        // Luego, actualiza el usuario autenticado
        _authenticatedUser = localUser;
        notifyListeners();
      } else {
        throw Exception('Error en la respuesta de la API');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('Error en la solicitud a la API');
    }
  }
}

class UserNotFoundException implements Exception {
  final String message;

  UserNotFoundException(this.message);
}

class InvalidCredentialsException implements Exception {
  final String message;

  InvalidCredentialsException(this.message);
}






// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:proyecto_qr/models/user.dart';

// class AuthProvider with ChangeNotifier {
//   final List<User> _localUsers = [
//     User('admin', '12345'),
//     User('usuario', '12345'),
//     // Agrega más usuarios aquí
//   ];

//   User? _authenticatedUser;

//   User? get authenticatedUser => _authenticatedUser;

//   Future<void> login(String username, String password) async {
//     final localUser = _localUsers.firstWhere(
//       (user) => user.username == username,
//       orElse: () => User('', ''),
//     );

//     if (localUser.username.isEmpty) {
//       throw UserNotFoundException('Usuario Incorrectos');
//     }

//     if (localUser.password != password) {
//       throw InvalidCredentialsException('Contraseña Incorrecta');
//     }

//     _authenticatedUser = localUser;
//     notifyListeners();
//   }
// }

// class UserNotFoundException implements Exception {
//   final String message;

//   UserNotFoundException(this.message);
// }

// class InvalidCredentialsException implements Exception {
//   final String message;

//   InvalidCredentialsException(this.message);
// }
