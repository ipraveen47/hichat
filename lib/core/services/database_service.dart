import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final _fire = FirebaseFirestore.instance;

  Future<void> saveUser(Map<String, dynamic> userData) async {
    try {
      await _fire.collection("users").doc(userData["uid"]).set(userData);
      log("user saved Successfully ");
    } catch (e) {
      rethrow;
    }
  }

  // method for loading a single user
  Future<Map<String, dynamic>?> loadUser(String uid) async {
    try {
      final res = await _fire.collection("users").doc(uid).get();
      if (res.data() != null) {
        log("user fetched Successfully");
        return res.data();
      }
    } catch (e) {
      rethrow;
    }
    return null;
  }
  // method for loading the list of users

  Future<List<Map<String, dynamic>>?> fetchUsers(String currentUserId) async {
    try {
      final res = await _fire
          .collection("users")
          .where("uid", isNotEqualTo: currentUserId)
          .get();

      return res.docs.map((e) => e.data()).toList();
    } catch (e) {
      rethrow;
    }
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> fetchUserStream(
          String currentUserId) =>
      _fire
          .collection("users")
          .where("uid", isNotEqualTo: currentUserId)
          .snapshots();
}
