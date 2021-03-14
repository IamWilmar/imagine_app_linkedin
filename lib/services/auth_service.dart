import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:imagine_app_linkedin/global/enviroment.dart';
import 'package:imagine_app_linkedin/models/auth_response.dart';
import 'package:imagine_app_linkedin/models/usuario_model.dart';

class AuthService with ChangeNotifier {
  Usuario usuario;
  bool _autenticando = false;

  bool get autenticando => this._autenticando;

  set autenticando(bool autenticando) {
    this._autenticando = autenticando;
  }

  final _storage = new FlutterSecureStorage();

  //Getter y setter del token
  static Future<String> getToken() async {
    final _storage = new FlutterSecureStorage();
    final token = _storage.read(key: 'token');
    return token;
  }

  static Future<void> deleteToken() async {
    final _storage = new FlutterSecureStorage();
    await _storage.delete(key: 'token');
  }

  //Interacciones con el almacenamiento de token
  Future _guardarToken(String token) async {
    return await _storage.write(key: 'token', value: token);
  }

  Future logout() async {
    await _storage.delete(key: 'token');
  }

  //Login method
  Future<bool> login(String email, String password) async {
    try {
      this._autenticando = true;
      final logInData = {'email': email, 'password': password};
      final Uri url = new Uri.https('${Enviroment.apiUrl}', '/api/login');
      final resp = await http.post(url,
          body: jsonEncode(logInData),
          headers: {'Content-Type': 'application/json'});  
      if (resp.statusCode == 200) {
        final loginResponse = authResponseFromJson(resp.body);
        this.usuario = loginResponse.usuario;
        await this._guardarToken(loginResponse.token);
        this._autenticando = false;  
        print(resp.body);
        return true;
      } else {
        this._autenticando = false;  
        notifyListeners();
        return false;
      }
    } catch (error) {
      this._autenticando = false;    
      notifyListeners();
      return false;
    }
  }

  //Registro del usuario
  Future register(String nombre, String email, String password) async {
    final registerData = {
      'nombre': nombre,
      'email': email,
      'password': password
    };
    final Uri url = new Uri.https('${Enviroment.apiUrl}', '/api/login/new');
    final resp = await http.post(url,
        body: jsonEncode(registerData),
        headers: {'Content-Type': 'application/json'});
    if (resp.statusCode == 200) {
      final registerResponse = authResponseFromJson(resp.body);
      this.usuario = registerResponse.usuario;
      this._guardarToken(registerResponse.token);
      return true;
    } else {
      return false;
    }
  }

  //SI token todavia es valido, Renueva el token
  Future<bool> isLoggedIn() async {
    final token = await this._storage.read(key: 'token');
    try {
      final Uri url = new Uri.https('${Enviroment.apiUrl}', '/api/login/renew');
      final resp = await http.get(url,
          headers: {'Content-Type': 'application/json', 'x-token': token});
      if (resp.statusCode == 200) {
        final isloggedResponse = authResponseFromJson(resp.body);
        this.usuario = isloggedResponse.usuario;
        await this._guardarToken(isloggedResponse.token);
        return true;
      } else {
        this.logout();
        return false;
      }
    } catch (error) {
      return false;
    }
  }
}
