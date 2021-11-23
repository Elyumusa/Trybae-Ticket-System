import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  FirebaseAuth auth = FirebaseAuth.instance;
  Future signIn(String email, String password) async {
    try {
      print('object');
      await auth.signInWithEmailAndPassword(email: email, password: password);
      print('object');
      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        return 'Wrong password provided for that user.';
      }
      return e.code;
    }
  }
}

class Database {
  final parties = FirebaseFirestore.instance.collection('Parties');
}
