import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:imagine_app_linkedin/models/usuario_model.dart';
import 'package:imagine_app_linkedin/providers/users_provider.dart';

/*
  Barra de estatus de usuarios
  Muestra la foto de los usuarios
  en una lista vertical
*/

class UserStatusBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //acceso al provider con la lista de usuarios
    final usersProvider = Provider.of<UsersProvider>(context);
    return Container(
      width: 10,
      height: 100,
      color: Colors.white,
      child: ListView.builder(
        itemCount: usersProvider.users.length, // Construye lista con los usuarios creados
        padding: EdgeInsets.symmetric(horizontal: 10),
        scrollDirection: Axis.horizontal,
        itemBuilder: (_, i) => _StatusItem(user: usersProvider.users[i]),
      ),
    );
  }
}

class _StatusItem extends StatelessWidget {
  final Usuario user;
  const _StatusItem({
    Key key,
    this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            child: CircleAvatar(
              radius: 30,
              child: ClipOval(
                child: FadeInImage(
                    fit: BoxFit.cover,
                    placeholder: AssetImage('assets/no-image.png'),
                    image: NetworkImage(user.photo)),
              ),
            ),
          ),
          SizedBox(height: 3),
          Text(user.nombre, overflow: TextOverflow.ellipsis),
        ],
      ),
    );
  }
}
