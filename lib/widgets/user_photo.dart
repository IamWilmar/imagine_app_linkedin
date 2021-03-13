import 'package:flutter/material.dart';

class CircularUserPhoto extends StatelessWidget {
  final String photo;
  const CircularUserPhoto({this.photo});
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      child: ClipOval(
        child: FadeInImage(
            height: 40,
            width: 40,
            fit: BoxFit.cover,
            placeholder: AssetImage('assets/no-image.png'),
            image: NetworkImage(photo)),
      ),
    );
  }
}
