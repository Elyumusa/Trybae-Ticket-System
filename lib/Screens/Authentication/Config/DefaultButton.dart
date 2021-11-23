import 'package:flutter/material.dart';
import 'package:trybae_ticket_system/Screens/Authentication/Config/palette.dart';

class DefaultButton extends StatelessWidget {
  final width;
  final Color? color;
  DefaultButton(
      {required this.onPressed, required this.string, this.width, this.color});
  final VoidCallback onPressed;
  final String string;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: SizedBox(
          width: width == null ? double.infinity : width,
          height: 56,
          child: Container(
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                  color: color != null
                      ? color
                      : Palette.lightBlue, //Colors.deepOrangeAccent,
                  borderRadius: BorderRadius.circular(20),
                  shape: BoxShape.rectangle), //RoundedRectangleBorder(),
              child: Center(
                child: Text(
                  string,
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ))),
    );
  }
}
