import 'package:flutter/material.dart';
import 'package:imagine_app_linkedin/models/post_model.dart';
import 'package:imagine_app_linkedin/services/post_service.dart';

class PostProvider with ChangeNotifier{
  String _de;
  String _privacy;
  String _content = '';
  String _username;
  String _userPhoto;
  String _photoContent = '';

  String get de => this._de;

  set de(String de) {
   this. _de = de;
  }

  String get privacy => this._privacy;

  set privacy(String privacy) {
    this._privacy = privacy;
  }

  String get content => this._content;

  set content(String content) {
    this._content = content;
  }

  String get username => _username;

  set username(String username) {
    this._username = username;
  }

  String get userPhoto => this._userPhoto;

  set userPhoto(String userPhoto) {
    this._userPhoto = userPhoto;
  }

  String get photoContent => this._photoContent;

  set photoContent(String photoContent) {
    this._photoContent = photoContent;
  }

  Future<void> sendPost() async {
    final PostService postService = new PostService();
    final post = new Post(
      de: this._de,
      content: this._content,
      privacy: this._privacy,
      userPhoto: this._userPhoto,
      username: this._username,
      photoContent: this._photoContent,
    );
    await postService.createPost(post);
    this._photoContent = '';
    this._content = '';
  }

}