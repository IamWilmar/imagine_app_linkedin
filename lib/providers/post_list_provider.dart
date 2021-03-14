
import 'package:flutter/cupertino.dart';
import 'package:imagine_app_linkedin/models/post_model.dart';
import 'package:imagine_app_linkedin/services/post_service.dart';

class PostListProvider with ChangeNotifier{
  List<Post> _posts = [];

  List<Post> get posts => this._posts;

  set posts(List<Post> posts) {
    this._posts = posts;
  }

  void getPosts() async {
    this._posts = await PostService.getPosts();
    notifyListeners();
  }

}