import 'package:flutter/material.dart';

class BlueButton extends StatelessWidget {
  final String text;
  final Function onPressed;
  const BlueButton({
    Key key,
    @required this.text,
    @required this.onPressed,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
      shape: const StadiumBorder(),
    ),
      onPressed: this.onPressed,
      child: Center(
        child: Text(
          this.text,
          style: TextStyle(color: Colors.white, fontSize: 17),
        ),
      ),
    );
  }
}