import 'dart:developer';

import 'package:hichat/core/enum/enum.dart';
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
  List<UserModel> _filterUsers = [];

  List<UserModel> get users => _users;
  List<UserModel> get filterUsers => _filterUsers;

  search(String value) {
    _filterUsers =
        _users.where((e) => e.name!.toLowerCase().contains(value)).toList();
    notifyListeners();
  }

  fetchUsers() async {
    try {
      setState(ViewState.loading);

      // final res = await _db.fetchUsers(_currentUser.uid!);
      _db.fetchUserStream(_currentUser.uid!).listen((data) {
        _users = data.docs.map((e) => UserModel.fromMap(e.data())).toList();
        _filterUsers = List.from(_users);
        notifyListeners();
      });
      // if (res != null) {
      //   _users = res.map((e) => UserModel.fromMap(e)).toList();
      //   _filterUsers = users;
      //   notifyListeners();
      // }
      setState(ViewState.idle);
    } catch (e) {
      setState(ViewState.idle);
      log("Error Fetching users : $e");
    }
  }
}
