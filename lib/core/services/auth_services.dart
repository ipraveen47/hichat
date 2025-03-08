import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';

class AuthServices {
  final _auth = FirebaseAuth.instance;

  Future<User?> signUp(String email, String password) async {
    try {
      final authCredential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      if (authCredential.user != null) {
        log("User Created Successfully");
        return authCredential.user!;
      }
    } on FirebaseAuthException catch (e) {
      log(e.message.toString());
      rethrow;
    } catch (e) {
      log(e.toString());
      rethrow;
    }
    return null;
  }

  Future login(String email, String password) async {
    try {
      final authCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      if (authCredential.user != null) {
        log("User Logged In Successfully");
        return authCredential.user!;
      }
    } on FirebaseAuthException catch (e) {
      log(e.message.toString());
      rethrow;
    } catch (e) {
      log(e.toString());
      rethrow;
    }
    return null;
  }

  Future<void> logout() async {
    try {
      await _auth.signOut();
    } catch (e) {
      log(e.toString());
    }
  }
}
