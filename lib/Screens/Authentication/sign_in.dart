import 'package:flutter/material.dart';
import 'package:trybae_ticket_system/Screens/Authentication/Config/palette.dart';
import 'package:trybae_ticket_system/Screens/Authentication/Config/sign_in.dart';
import 'package:trybae_ticket_system/Screens/Authentication/cloud_test.dart';

import 'SignInPainter.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> with TickerProviderStateMixin {
  TextEditingController id_controller = TextEditingController();
  TextEditingController password_controller = TextEditingController();
  late AnimationController _controller;
  ColorTween colorTween =
      ColorTween(begin: Palette.lightBlue, end: Palette.darkBlue);
  @override
  void initState() {
    // TODO: implement initState
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 2));
    _controller.forward();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox.expand(
            child: CustomPaint(
              painter: SignInPainter(animation: _controller.view),
            ),
          ),
          SignInForm(
              controller: _controller,
              id_controller: id_controller,
              password_controller: password_controller)
        ],
      ),
    );
  }
}
