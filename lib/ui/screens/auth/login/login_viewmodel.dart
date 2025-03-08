import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:hichat/core/enum/enum.dart';
import 'package:hichat/core/other/base_view_model.dart';
import 'package:hichat/core/services/auth_services.dart';

class LoginViewmodel extends BaseViewModel {
  final AuthServices _auth;

  LoginViewmodel(this._auth);

  String _email = '';
  String _password = '';

  void setEmail(String value) {
    _email = value;
    log("Email $_email");
    notifyListeners();
  }

  void setPassword(String value) {
    _password = value;
    log("Password : $_password");
    notifyListeners();
  }

  login() async {
    setState(ViewState.loading);
    try {
      await _auth.login(_email, _password);
      setState(ViewState.idle);
    } on FirebaseAuthException catch (e) {
      rethrow;
    } catch (e) {
      log(e.toString());
      setState(ViewState.idle);
    }
  }
}
