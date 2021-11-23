import 'package:flutter/material.dart';
import 'package:trybae_ticket_system/Screens/Authentication/Config/DefaultButton.dart';

import 'Config/auth_services.dart';
import 'Config/background_painter.dart';
import '../HomePage/home_page.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

TextEditingController id_controller = TextEditingController();
TextEditingController password_controller = TextEditingController();

class _AuthScreenState extends State<AuthScreen>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Form(
                  child: Column(
                children: [
                  TextFormField(
                    controller: id_controller,
                    autofocus: true,
                    onSaved: (value) {},
                    onChanged: (value) {},
                    decoration: InputDecoration(
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 42, vertical: 20),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      hintText: 'Enter Host ID',
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
                    controller: password_controller,
                    onSaved: (value) {},
                    onChanged: (value) {},
                    decoration: InputDecoration(
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 42, vertical: 20),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      hintText: 'Enter the password',
                      suffixIcon: Icon(Icons.email_outlined),
                      labelText: 'Password',
                    ),
                    // ignore: missing_return
                    validator: (value) {},
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  DefaultButton(
                      onPressed: () async {
                        /*bool returnedValue = await AuthService().signIn(
                            id_controller.text, password_controller.text);
                        returnedValue
                            ? Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HomePage()))
                            : print('An error occured');*/
                      },
                      string: 'Continue'),
                ],
              )),
            ),
          ],
        ),
      )),
    );
  }
}
