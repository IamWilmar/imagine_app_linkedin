import 'package:flutter/material.dart';
import 'package:imagine_app_linkedin/providers/post_provider.dart';
import 'package:provider/provider.dart';

/*
Widgets de Post
*/
//Nombre del usuario 
class NameButton extends StatelessWidget {
  final String userName;
  const NameButton({Key key, this.userName}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 1, horizontal: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: Colors.white,
        border: Border.all(color: Colors.grey),
      ),
      child: Row(
        children: <Widget>[
          Icon(Icons.person, size: 16),
          SizedBox(width: 1),
          Text(this.userName),
          SizedBox(width: 1),
          Icon(Icons.arrow_drop_down),
        ],
      ),
    );
  }
}

//Separador gris para los modalbottomSheet
class GreyUpperSeparator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        width: 50,
        height: 4,
        decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.circular(50),
        ),
      ),
    );
  }
}

//Item de la barra inferior en la pagina para crear post
class PostCreationItem extends StatelessWidget {
  final IconData icon;
  final VoidCallback function;
  const PostCreationItem({
    this.icon,
    this.function,
  });
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(icon, color: Colors.grey[500]),
      onPressed: function,
    );
  }
}

//Boton para cambio de privacidad
class BottomPrivacyButton extends StatelessWidget {
  final privacyStyle =
      TextStyle(color: Colors.grey, fontWeight: FontWeight.bold);
  final VoidCallback function;
  BottomPrivacyButton({this.function});
  @override
  Widget build(BuildContext context) {
    final PostProvider postProvider = Provider.of<PostProvider>(context);
    return InkWell(
      child: Container(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(Icons.message_outlined, size: 16, color: Colors.grey),
            Text(
                (postProvider.privacy != null)
                    ? postProvider.privacy
                    : "Anyone",
                style: privacyStyle),
          ],
        ),
      ),
      onTap: function,
    );
  }
}