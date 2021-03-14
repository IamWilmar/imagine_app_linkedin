import 'package:flutter/material.dart';

/*
  Iconos de reacción a un post
  Se encuentran en cada post
  Contiene like, comenntarios, etc
*/
class InteractionButton extends StatelessWidget {
  final IconData icon;
  final String buttonName;
  const InteractionButton({
    Key key,
    this.icon,
    this.buttonName,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon),
        Text(buttonName),
      ],
    );
  }
}