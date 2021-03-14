/* 
  Modelo para recibir la respuesta de al API al solicitar
  un inicio de sesión
*/
import 'dart:convert';
import 'package:imagine_app_linkedin/models/usuario_model.dart';

AuthResponse authResponseFromJson(String str) => AuthResponse.fromJson(json.decode(str));

String authResponseToJson(AuthResponse data) => json.encode(data.toJson());

class AuthResponse {
    
    AuthResponse({
        this.ok,
        this.usuario,
        this.token,
    });

    bool ok;
    Usuario usuario;
    String token;

    //mapea los valores de Json a los atributos de la clase
    factory AuthResponse.fromJson(Map<String, dynamic> json) => AuthResponse(
        ok: json["ok"],
        usuario: Usuario.fromJson(json["usuario"]),
        token: json["token"],
    );

    //Proceso inverso al anterior
    Map<String, dynamic> toJson() => {
        "ok": ok,
        "usuario": usuario.toJson(),
        "token": token,
    };
}
