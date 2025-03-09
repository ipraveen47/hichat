import 'dart:developer';

import 'package:hichat/core/models/user_model.dart';
import 'package:hichat/core/other/base_view_model.dart';
import 'package:hichat/core/services/database_service.dart';

class ChatListViewmodel extends BaseViewModel {
  final DatabaseService _db;
  final UserModel _currentUser;

  ChatListViewmodel(this._db, this._currentUser) {
    fetchUsers();
  }

  List<UserModel> _users = [];

  List<UserModel> get users => _users;
  fetchUsers() async {
    try {
      // TODO : Fetch Users Data
      final res = await _db.fetchUsers(_currentUser.uid!);
      if (res != null) {
        _users = res.map((e) => UserModel.fromMap(e)).toList();
        notifyListeners();
      }
    } catch (e) {
      log("Error Fetching users : $e");
    }
  }
}
