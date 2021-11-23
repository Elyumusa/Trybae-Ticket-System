import 'package:flutter/material.dart';

class AlreadyIn extends StatefulWidget {
  final bool alreadyIn;
  const AlreadyIn({Key? key, required this.alreadyIn}) : super(key: key);

  @override
  _AlreadyInState createState() => _AlreadyInState();
}

class _AlreadyInState extends State<AlreadyIn> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Text(
        '${widget.alreadyIn.toString().toUpperCase()}',
        style: TextStyle(fontSize: 15),
        textAlign: TextAlign.center,
      ),
      decoration: BoxDecoration(
          color: widget.alreadyIn ? Colors.green : Colors.red,
          borderRadius: BorderRadius.circular(8)),
    );
  }
}
