import 'package:http/http.dart' as http;
import 'package:imagine_app_linkedin/global/enviroment.dart';
import 'package:imagine_app_linkedin/models/users_response.dart';
import 'package:imagine_app_linkedin/models/usuario_model.dart';
import 'package:imagine_app_linkedin/services/auth_service.dart';

/*
  Servicio par obtener los usuarios
  Se usa en Home para observar el estatus de los usuarios.

 */
class UsersService {
  //Realiza un request de todos los usuarios
  static Future<List<Usuario>> getUser() async {
    try {
      final Uri url = Uri.https('${Enviroment.apiUrl}', '/api/usuarios');
      final resp = await http.get(url, headers: {
        'Content-Type': 'application/json',
        'x-token': await AuthService.getToken() //Token Necesario
      });
      final usuarioResponse = usersResponseFromJson(resp.body);
      return usuarioResponse.usuarios; // devuelve la lista de usuarios
    } catch (e) {
      return []; // devuelve una lista vacia si el proceso falla
    }
  }
}
