import 'dart:developer';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:hichat/core/enum/enum.dart';
import 'package:hichat/core/models/user_model.dart';
import 'package:hichat/core/other/base_view_model.dart';
import 'package:hichat/core/services/auth_services.dart';
import 'package:hichat/core/services/database_service.dart';
import 'package:hichat/core/services/storage_service.dart';
import 'package:image_picker/image_picker.dart';

class SignpViewmodel extends BaseViewModel {
  final AuthServices _auth;
  final DatabaseService _db;
  final StorageService _storage;

  SignpViewmodel(this._auth, this._db, this._storage);

  final _picker = ImagePicker();

  String _name = "";
  String _email = "";
  String _password = "";
  String _confirmPassword = "";

  File? _image;

  File? get image => _image;

  pickImage() async {
    log("Pic Image ");
    final pic = await _picker.pickImage(source: ImageSource.gallery);

    if (pic != null) {
      _image = File(pic.path);
      notifyListeners();
    }
  }

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
    String? downloadUrl;
    setState(ViewState.loading);
    try {
      if (_password != _confirmPassword) {
        throw Exception("Paswords Do not Match");
      }
      final res = await _auth.signUp(_email, _password);

      if (res != null) {
        if (_image != null) {
          log("Uploading Image ....");
          downloadUrl = await _storage.uploadImage(_image!);
          log("Image Uploaded $downloadUrl");
        }

        UserModel user = UserModel(
          uid: res.uid,
          name: _name,
          email: _email,
          imageUrl: downloadUrl,
        );

        await _db.saveUser(user.toMap());
      }

      setState(ViewState.idle);
    } on FirebaseAuthException catch (e) {
      setState(ViewState.idle);
      rethrow;
    } catch (e) {
      log(e.toString());
      setState(ViewState.idle);
    }
  }
}
