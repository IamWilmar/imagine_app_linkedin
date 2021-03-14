
import 'package:flutter/cupertino.dart';
import 'package:imagine_app_linkedin/models/usuario_model.dart';
import 'package:imagine_app_linkedin/services/users_service.dart';
/*
  Provider que guarda los usuarios existentes
  Se usa en la paginade inicion Home
 */
class UsersProvider with ChangeNotifier{
  List<Usuario> _users = [];

  List<Usuario> get users => this._users;

  set users(List<Usuario> users) {
    this._users = users;
    notifyListeners();
  }

  //Guarda los usuarios en el atributo _users
  Future<void> getUsers() async {
    this._users = await UsersService.getUser(); // hace un request a la API
    notifyListeners(); //Notifica de un cambio a los widgets que escuchan este provider
  }

}