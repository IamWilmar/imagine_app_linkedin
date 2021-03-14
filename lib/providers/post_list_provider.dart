
import 'package:flutter/cupertino.dart';
import 'package:imagine_app_linkedin/models/post_model.dart';
import 'package:imagine_app_linkedin/services/post_service.dart';
/*
  Provider para guardar la lista de Post
  Usado en la pagina Home
 */
class PostListProvider with ChangeNotifier{
  List<Post> _posts = [];

  //Getter y Setter
  List<Post> get posts => this._posts;

  set posts(List<Post> posts) {
    this._posts = posts;
  }

  //Llama a la function getPost en postService
  //y recibe los post publicados para guardarlos en this._post
  void getPosts() async {
    this._posts = await PostService.getPosts();
    notifyListeners(); //notifica a los widgets que escuchen este provider y los reconstruye
  }

}