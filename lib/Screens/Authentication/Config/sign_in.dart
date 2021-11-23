import 'package:flutter/material.dart';
import 'package:trybae_ticket_system/Screens/Authentication/Config/palette.dart';
import 'package:trybae_ticket_system/Screens/HomePage/home_page.dart';

import 'DefaultButton.dart';
import 'auth_services.dart';

class SignInForm extends StatefulWidget {
  SignInForm({
    Key? key,
    required this.controller,
    required this.id_controller,
    required this.password_controller,
  }) : super(key: key);

  final AnimationController controller;
  final TextEditingController id_controller;
  final TextEditingController password_controller;

  @override
  State<SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  bool obscure = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 120, left: 12, right: 12),
      child: Column(
        //mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Sign In',
                style: TextStyle(fontSize: 34, color: Colors.white),
              ),
            ),
          ),
          Center(
            child: ElevatedButton(
                onPressed: () {
                  widget.controller.forward(from: 0);
                },
                child: Text('Animate')),
          ),
          Expanded(
            child: Form(
                child: ListView(
              children: [
                TextFormField(
                  controller: widget.id_controller,
                  //autofocus: true,
                  onSaved: (value) {},
                  onChanged: (value) {},
                  decoration: InputDecoration(
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 42, vertical: 20),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Palette.darkBlue),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    hintText: 'Enter Host ID',
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    suffixIcon: Icon(Icons.email_outlined),
                    labelText: 'Host ID',
                  ),
                  // ignore: missing_return
                  validator: (value) {},
                ),
                SizedBox(
                  height: 16,
                ),
                TextFormField(
                  controller: widget.password_controller,
                  onSaved: (value) {},
                  onChanged: (value) {},
                  obscureText: obscure,
                  decoration: InputDecoration(
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 42, vertical: 20),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Palette.darkBlue),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    hintText: 'Enter the password',
                    suffixIcon: IconButton(
                      icon: Icon(Icons.password_outlined),
                      onPressed: () {
                        setState(() {
                          obscure ? obscure = false : true;
                        });
                      },
                    ),
                    labelText: 'Password',
                  ),
                  // ignore: missing_return
                  validator: (value) {},
                ),
                SizedBox(
                  height: 16,
                ),
                DefaultButton(
                    color: Palette.darkBlue,
                    onPressed: () async {
                      // Navigator.push(context,                         MaterialPageRoute(builder: (context) => HomePage()));
                      var returnedValue = await AuthService().signIn(
                          widget.id_controller.text,
                          widget.password_controller.text);
                      returnedValue
                          ? Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomePage()))
                          : showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                content: Text(returnedValue),
                              ),
                            );
                    },
                    string: 'Continue'),
              ],
            )),
          ),
        ],
      ),
    );
  }
}
