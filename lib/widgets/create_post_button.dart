import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:imagine_app_linkedin/providers/post_provider.dart';


/*
  Boton para publicar Post
  Se usa en la pagina de creación de Posts
 */
class PostButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final postProvider = Provider.of<PostProvider>(context); // acceso al provider
    return InkWell(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Text(
          'Post',
          style: TextStyle(
              color: postProvider.content.trim().length > 0
                  ? Colors.black
                  : Colors.grey,
              fontSize: 16,
              fontWeight: FontWeight.bold),
        ),
      ),
      onTap: (postProvider.content.trim().length < 0)
          ? null
          : () => _createPostandLeavePage(context),
    );
  }

  //Llama al metodo para crear post del Provider
  // y retorna a la pantalla home
  void _createPostandLeavePage(BuildContext context) async {
    final postProvider = Provider.of<PostProvider>(context, listen: false);
    await postProvider.sendPost();
    Navigator.pushReplacementNamed(context, 'home');
  }
}