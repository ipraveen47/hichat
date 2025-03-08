import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hichat/core/enum/enum.dart';
import 'package:hichat/core/models/user_model.dart';
import 'package:hichat/core/other/base_view_model.dart';
import 'package:hichat/core/services/auth_services.dart';
import 'package:hichat/core/services/database_service.dart';
import 'package:provider/provider.dart';

class SignpViewmodel extends BaseViewModel {
  final AuthServices _auth;
  final DatabaseService _db;

  SignpViewmodel(this._auth, this._db);

  String _name = "";
  String _email = "";
  String _password = "";
  String _confirmPassword = "";

  setName(String value) {
    _name = value;
    notifyListeners();

    log("Name : $_name");
  }

  setEmail(String value) {
    _email = value;
    notifyListeners();
    log("Email : $_email");
  }

  setPassword(String value) {
    _password = value;
    notifyListeners();
    log("Password : $_password");
  }

  setConfirmPassword(String value) {
    _confirmPassword = value;
    notifyListeners();
    log("Confirm Password : $_confirmPassword");
  }

  signup() async {
    setState(ViewState.loading);
    try {
      final res = await _auth.signUp(_email, _password);

      if (res != null) {
        UserModel user = UserModel(
          uid: res.uid,
          name: _name,
          email: _email,
          imageUrl: '',
        );

        await _db.saveUser(user.toMap());
      }

      setState(ViewState.idle);
    } on FirebaseAuthException catch (e) {
      rethrow;
    } catch (e) {
      log(e.toString());
      setState(ViewState.idle);
    }
  }
}
