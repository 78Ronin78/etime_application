import 'package:flutter/material.dart';

class ControlButton extends StatelessWidget {
  const ControlButton({Key? key, required this.onPressed, required this.title})
      : super(key: key);

  final VoidCallback onPressed;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            primary: Color.fromARGB(255, 10, 13, 66),
            textStyle: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            )),
        onPressed: onPressed,
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(color: Color.fromARGB(255, 249, 22, 112)),
        ),
      ),
    );
  }
}
