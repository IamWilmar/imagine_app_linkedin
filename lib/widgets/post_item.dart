import 'package:flutter/material.dart';
import 'package:imagine_app_linkedin/models/post_model.dart';
import 'package:imagine_app_linkedin/services/auth_service.dart';
import 'package:imagine_app_linkedin/services/post_service.dart';
import 'package:imagine_app_linkedin/widgets/interaction_button.dart';
import 'package:imagine_app_linkedin/widgets/separation_dot.dart';
import 'package:provider/provider.dart';


/*
  Widget para mostrar los post en la pagina Home
 */

class PostItem extends StatelessWidget {
  final Post post;
  const PostItem({Key key, this.post}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 7),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _userInfo(context, post),
          SizedBox(height: 10),
          _postContent(),
          // Si el post tiene una imagen la muestra, si no es el caso no
          if (this.post.photoContent.length > 4) ...[
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: FadeInImage(
                fit: BoxFit.cover,
                placeholder: AssetImage('assets/no-image.png'),
                image: NetworkImage(this.post.photoContent),
              ),
            ),
          ],
          _reactionBar(), // Crear la barra de reacciones(likes)
          Divider(),
          _interactionBar(), // Crea los botones de interaccion con el post
        ],
      ),
    );
  }

  Widget _userInfo(context, Post post) {
    return Row(
      children: <Widget>[
        CircleAvatar(
          child: ClipOval(
            child: FadeInImage(
              height: 40,
              width: 40,
              fit: BoxFit.cover,
              placeholder: AssetImage('assets/no-image.png'),
              image: NetworkImage(this.post.userPhoto),
            ),
          ),
        ),
        SizedBox(width: 5),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: [
                Text(this.post.username),
                SeparationDot(),
                Text('1st'),
              ],
            ),
            Text('Current job of the user'),
            Row(
              children: <Widget>[
                Text('41m'),
                SeparationDot(),
                Text('Edited'),
                SeparationDot(),
                Icon(Icons.public, size: 15),
              ],
            ),
          ],
        ),
        Expanded(child: SizedBox()),
        //Pop menu Para borrar el post
        PopupMenuButton(
          onSelected: (int index) async {
            final authService = Provider.of<AuthService>(context, listen: false);
            final postService = PostService();
            if (authService.usuario.uid == post.de && index == 0) {
              await postService.borrarPost(post.uid); // Llama a la funcion para borrar post
              Navigator.pushReplacementNamed(context, 'home'); // navega a home
            }
          },
          icon: Icon(Icons.more_horiz),
          itemBuilder: (context) {
            return [
              PopupMenuItem(
                value: 0, //valor que debe ser index en onSelected(Linea 88) para borrar
                child: Text('Borrar Post'),
              ),
            ];
          },
        ),
        //IconButton(icon: Icon(Icons.more_horiz), onPressed: () {})
      ],
    );
  }

  Widget _postContent() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(this.post.content, maxLines: 4, overflow: TextOverflow.fade),
        ],
      ),
    );
  }

  Widget _reactionBar() {
    return Container(
      padding: EdgeInsets.only(left: 5),
      child: Row(
        children: [
          Icon(Icons.thumb_up_alt_rounded, size: 15, color: Colors.blue),
          SizedBox(width: 3),
          Text('1'),
        ],
      ),
    );
  }

  Widget _interactionBar() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          InteractionButton(
              icon: Icons.thumb_up_alt_outlined, buttonName: 'Like'),
          InteractionButton(
              icon: Icons.comment_outlined, buttonName: 'Comment'),
          InteractionButton(icon: Icons.share, buttonName: 'Share'),
          InteractionButton(icon: Icons.send, buttonName: 'Send'),
        ],
      ),
    );
  }
}



