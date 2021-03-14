import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:imagine_app_linkedin/global/enviroment.dart';
import 'package:imagine_app_linkedin/models/post_model.dart';
import 'package:imagine_app_linkedin/models/posts_response.dart';
import 'package:imagine_app_linkedin/services/auth_service.dart';

class PostService {

  //Se crea un metodo estatico para Obtener los Posts de API 
  //se accede a esta funcion desde el provider de Posts
  static Future<List<Post>> getPosts() async {
    try {
      final Uri url = new Uri.https('${Enviroment.apiUrl}', '/api/posts');
      final resp = await http.get(
        url,
        headers: ({
          'Content-Type': 'application/json',
          'x-token': await AuthService.getToken(),
        }),
      );
      final postsResp = postsResponseFromJson(resp.body);
      print(resp.body);
      return postsResp.posts; //devuelve la lita de post
    } catch (error) {
      return [];
    }
  }

  //Crea un post y lo guarda en la base de datos
  Future<void> createPost(Post newpost) async {
    try {
      final Uri url = Uri.https('${Enviroment.apiUrl}', '/api/posts/new');
      //post request a la API
      final resp = await http.post(
        url,
        body: (jsonEncode({
          'de': newpost.de,
          'privacy': newpost.privacy,
          'content': newpost.content,
          'userPhoto': newpost.userPhoto,
          'username' : newpost.username,
          'photoContent' : newpost.photoContent
        })),
        headers: ({
          'Content-Type': 'application/json',
          'x-token': await AuthService.getToken(),// es necesario el token en cada request
        }),
      );
    } catch (error) {
      print('error');
    }
  }

  //Borra un post dependiendo de su Id
  Future<void> borrarPost(String postId) async {
    try{
      final Uri url = Uri.https('${Enviroment.apiUrl}', '/api/posts/delete/$postId');
      final resp = await http.delete(url, headers: ({
        'Content-Type' : 'application/json',
        'x-token': await AuthService.getToken() // Token necesario
      }));
    }catch(error){
      print(error);
    }
  }

}
