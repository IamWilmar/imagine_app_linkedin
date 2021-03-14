import 'package:flutter/cupertino.dart';

class LoginProvider with ChangeNotifier {
  String _username = '';
  String _password = '';

  String get username => this._username;

  set username(String username) {
    this._username = username;
    notifyListeners();
  }

  String get password => this._password;

  set password(String password) {
    this._password = password;
    notifyListeners();
  }

  void resetValues(){
    this._password = '';
    this._username = '';
  }

}
