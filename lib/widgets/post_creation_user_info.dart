import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:imagine_app_linkedin/providers/post_provider.dart';
import 'package:imagine_app_linkedin/services/auth_service.dart';
import 'package:imagine_app_linkedin/widgets/post_page_widgets.dart';
import 'package:imagine_app_linkedin/widgets/user_photo.dart';

/* 
  Información del usuario
  En la paginal de creación de post
*/
class UserTopInfo extends StatelessWidget {
  final VoidCallback onPressed;
  const UserTopInfo({Key key, this.onPressed});
  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context); //Acceso al provider para info de user
    return Padding(
      padding: const EdgeInsets.only(left: 10, top: 14),
      child: Row(
        children: <Widget>[
          CircularUserPhoto(photo: authService.usuario.photo), // Foto del usuario
          SizedBox(width: 5),
          NameButton(userName: authService.usuario.nombre),
          SizedBox(width: 5),
          UpperPrivacyButton(onPressed: () => onPressed()), // Despliega boton de privacidad
        ],
      ),
    );
  }
}


class UpperPrivacyButton extends StatelessWidget {
  final VoidCallback onPressed;
  const UpperPrivacyButton({this.onPressed});
  @override
  Widget build(BuildContext context) {
    final PostProvider postProvider = Provider.of<PostProvider>(context);
    return InkWell(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 1, horizontal: 5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: Colors.white,
          border: Border.all(color: Colors.grey),
        ),
        child: Row(
          children: <Widget>[
            Icon(Icons.public, size: 16),
            SizedBox(width: 1),
            Text((postProvider.privacy != null)
                ? postProvider.privacy
                : "Anyone"),
            SizedBox(width: 1),
            Icon(Icons.arrow_drop_down),
          ],
        ),
      ),
      onTap: onPressed,
    );
  }
}


