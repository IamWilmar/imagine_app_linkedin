import 'package:flutter/material.dart';
import 'package:imagine_app_linkedin/widgets/post_page_widgets.dart';

/*
  Barra inferior en la pagina de creacion de post  
*/

class PostCreationBottomBar extends StatelessWidget {
  final VoidCallback onPressedEllipsis;
  final VoidCallback onPressedPrivacy;
  const PostCreationBottomBar({
    Key key,
    this.onPressedEllipsis,
    this.onPressedPrivacy,
  });
  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 0,
      right: 0,
      bottom: 0,
      height: kToolbarHeight,
      child: Container(
        padding: EdgeInsets.only(left: 10, right: 7),
        color: Colors.white,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            PostCreationItem(icon: Icons.camera_alt_rounded, function: () {}),
            PostCreationItem(icon: Icons.video_call_rounded, function: () {}),
            PostCreationItem(icon: Icons.image_outlined, function: () {}),
            PostCreationItem(
                icon: Icons.more_horiz, function: onPressedEllipsis),
            Expanded(child: SizedBox(width: 1)), // Separa las acciones con el boton de privacidad
            BottomPrivacyButton(function: onPressedPrivacy),
          ],
        ),
      ),
    );
  }
}