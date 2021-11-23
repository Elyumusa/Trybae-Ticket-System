import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:trybae_ticket_system/Screens/Authentication/Config/DefaultButton.dart';
import 'package:trybae_ticket_system/Screens/Authentication/Config/background_painter.dart';
import 'package:trybae_ticket_system/Screens/Authentication/scan.dart';
import 'package:trybae_ticket_system/Screens/HomePage/party_form.dart';

import '../Authentication/Config/sign_in.dart';
import '../Authentication/manage_party.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  TextEditingController id_controller = TextEditingController();
  late AnimationController controller;
  TextEditingController password_controller = TextEditingController();
  bool onChanged = false;
  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 2),
    vsync: this,
  );
  late final Animation<Offset> _offsetAnimation = Tween<Offset>(
    begin: Offset.zero,
    end: const Offset(0.2, 0.0),
  ).animate(CurvedAnimation(
    parent: _controller,
    curve: Curves.elasticIn,
  ));

  @override
  void initState() {
    // TODO: implement initState
    controller =
        AnimationController(vsync: this, duration: Duration(seconds: 3));
    _controller.forward().whenComplete(() => _controller.reverse());
    controller.forward(from: 0);
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Scaffold(
      body: Stack(
        children: [
          SizedBox.expand(
            child: CustomPaint(
              painter: BackgroundPainter(animation: controller.view),
            ),
          ),
          PartyForm(
              offsetAnimation: _offsetAnimation, id_controller: id_controller)
        ],
      ),
    );
    /*return Scaffold(
      body: SafeArea(
          child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15),
              child: Center(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 10.0),
                      child: Text('TRYBAE GROUP',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              height: 1.5)),
                    ),
                    Center(
                      child: Text(
                        'Welcome To Party Management Dashboard click the button and enter the party id for the party you want to manage right now',
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Spacer(),
                    TextFormField(
                      controller: id_controller,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
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
                        hintText: 'Enter Party ID',
                        suffixIcon: Icon(Icons.email_outlined),
                        labelText: 'Party ID',
                      ),
                      // ignore: missing_return
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter valid Part ID';
                        }
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    DefaultButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ManageParty(
                                      partyID: id_controller.text.trim())));
                        },
                        string: 'Manage'),
                    Spacer(
                      flex: 2,
                    )
                  ])))),
    );
  */
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  _MyStatefulWidgetState createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 2),
    vsync: this,
  );
  late final Animation<Offset> _offsetAnimation = Tween<Offset>(
    begin: Offset.zero,
    end: const Offset(1.5, 0.0),
  ).animate(CurvedAnimation(
    parent: _controller,
    curve: Curves.elasticIn,
  ));

  @override
  void dispose() {
    super.dispose();

    _controller.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    _controller.forward().whenComplete(() => _controller.reverse());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print('o: ${_offsetAnimation.value}');
    return SlideTransition(
        position: _offsetAnimation,
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Column(children: [])));
  }
}
