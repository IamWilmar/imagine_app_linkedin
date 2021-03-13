class Post {
    Post({
        this.photoContent,
        this.de,
        this.privacy,
        this.content,
        this.username,
        this.userPhoto,
        this.createdAt,
        this.updatedAt,
        this.uid,
    });

    String photoContent;
    String de;
    String privacy;
    String content;
    String username;
    String userPhoto;
    DateTime createdAt;
    DateTime updatedAt;
    String uid;

    factory Post.fromJson(Map<String, dynamic> json) => Post(
        photoContent: json["photoContent"],
        de: json["de"],
        privacy: json["privacy"],
        content: json["content"],
        username: json["username"],
        userPhoto: json["userPhoto"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        uid: json["uid"],
    );

    Map<String, dynamic> toJson() => {
        "photoContent": photoContent,
        "de": de,
        "privacy": privacy,
        "content": content,
        "username": username,
        "userPhoto": userPhoto,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "uid": uid,
    };
}