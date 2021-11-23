import 'package:flutter/material.dart';
import 'package:trybae_ticket_system/Screens/Authentication/Config/DefaultButton.dart';
import 'package:trybae_ticket_system/Screens/Authentication/manage_party.dart';

class PartyForm extends StatelessWidget {
  final Animation<Offset> offsetAnimation;
  final TextEditingController id_controller;
  const PartyForm({
    Key? key,
    required this.offsetAnimation,
    required this.id_controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
            position: offsetAnimation,
            child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Column(children: [
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'TRYBAE PARTIES',
                        style: TextStyle(fontSize: 34, color: Colors.white),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Form(
                      child: Column(
                        children: [
                          TextFormField(
                            controller: id_controller,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,

                            onSaved: (value) {},
                            onChanged: (value) {},
                            decoration: InputDecoration(
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 42, vertical: 20),
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
                                            partyID:
                                                id_controller.text.trim())));
                              },
                              string: 'Manage'),
                          Spacer()
                        ],
                      ),
                    ),
                  )
                ]))) /*SignInForm(
              controller: controller,
              id_controller: id_controller,
              password_controller: password_controller)*/
        ;
  }
}
