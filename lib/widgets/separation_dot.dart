import 'package:flutter/material.dart';
/*
  Widget para separa elementos con un punto
  Se encuentra en los posts en Home
*/
class SeparationDot extends StatelessWidget {
  const SeparationDot({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5),
      width: 5,
      height: 5,
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular(100.0),
      ),
    );
  }
}