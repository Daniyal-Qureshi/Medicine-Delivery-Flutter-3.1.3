import 'package:firebase_auth/firebase_auth.dart';

class Authentication {
  static final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  // ignore: constant_identifier_names
  static const INVALID_ERROR = "INVALID_LOGIN_CREDENTIALS";
  // ignore: constant_identifier_names
  static const ALREADY_IN_USE = "email-already-in-use";
  static const WEAK_PASSWORD = "weak-password";
  static Future<String> registerUser(String email, String password) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == WEAK_PASSWORD) {
        return 'The password provided is too weak.';
      } else if (e.code == ALREADY_IN_USE) {
        return 'The account already exists for that email.';
      }
    } catch (e) {
      return e.toString();
    }
    return "ok";
  }

  static Future<String> loginUser(String email, String password) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == INVALID_ERROR) {
        return "Invalid Details Provided";
      }
      return e.message.toString();
    }
    return "ok";
  }
}
