import 'package:flutter/cupertino.dart';

/*
  Provider para el login
  Usado para activar el boton de Login
 */

class LoginProvider with ChangeNotifier {
  String _username = '';
  String _password = '';

  String get username => this._username;

  set username(String username) {
    this._username = username;
    notifyListeners();//Notifica a todos los widgets que escuchen a este atributo
  }

  String get password => this._password;

  set password(String password) {
    this._password = password;
    notifyListeners();//Notifica a todos los widgets que escuchen a este atributo
  }

  //Se usa para resetear los valores despeus del login
  void resetValues(){
    this._password = '';
    this._username = '';
  }

}
