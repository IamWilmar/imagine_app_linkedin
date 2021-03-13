
import 'package:flutter/cupertino.dart';
import 'package:imagine_app_linkedin/models/usuario_model.dart';
import 'package:imagine_app_linkedin/services/users_service.dart';

class UsersProvider with ChangeNotifier{
  List<Usuario> _users = [];

  List<Usuario> get users => this._users;

  set users(List<Usuario> users) {
    this._users = users;
    notifyListeners();
  }

  Future<void> getUsers() async {
    this._users = await UsersService.getUser();
    notifyListeners();
  }

}