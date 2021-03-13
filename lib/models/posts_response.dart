// To parse this JSON data, do
//
//     final postsResponse = postsResponseFromJson(jsonString);

import 'dart:convert';

import 'package:imagine_app_linkedin/models/post_model.dart';

PostsResponse postsResponseFromJson(String str) => PostsResponse.fromJson(json.decode(str));

String postsResponseToJson(PostsResponse data) => json.encode(data.toJson());

class PostsResponse {
    PostsResponse({
        this.ok,
        this.posts,
    });

    bool ok;
    List<Post> posts;

    factory PostsResponse.fromJson(Map<String, dynamic> json) => PostsResponse(
        ok: json["ok"],
        posts: List<Post>.from(json["posts"].map((x) => Post.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "ok": ok,
        "posts": List<dynamic>.from(posts.map((x) => x.toJson())),
    };
}
