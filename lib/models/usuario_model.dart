//Modelo del Usuario
class Usuario {
    Usuario({
        this.photo,
        this.nombre,
        this.email,
        this.uid,
    });

    String photo;
    String nombre;
    String email;
    String uid;

    factory Usuario.fromJson(Map<String, dynamic> json) => Usuario(
        photo: json["photo"],
        nombre: json["nombre"],
        email: json["email"],
        uid: json["uid"],
    );

    Map<String, dynamic> toJson() => {
        "photo": photo,
        "nombre": nombre,
        "email": email,
        "uid": uid,
    };
}