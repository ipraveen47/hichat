import 'dart:convert';

class UserModel {
  final String? uid;
  final String? name;
  final String? email;
  final String? imageUrl;
  final Map<String, dynamic>? lastMessage;
  final int? unreadCounter;

  UserModel({
    this.uid,
    this.lastMessage,
    this.unreadCounter,
    this.name,
    this.email,
    this.imageUrl,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'name': name,
      'email': email,
      'imageUrl': imageUrl,
      'lastMessage': lastMessage,
      'unreadCounter': unreadCounter
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'] != null ? map['uid'] as String : null,
      name: map['name'] != null ? map['name'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
      imageUrl: map['imageUrl'] != null ? map['imageUrl'] as String : null,
      lastMessage: map['lastMessage'] != null
          ? Map<String, dynamic>.from(
              map['lastMessage'] as Map<String, dynamic>)
          : null,
      unreadCounter:
          map['unreadCounter'] != null ? map['unreadCounter'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(jsonDecode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserModel(uid: $uid, name: $name, email $email, image: $imageUrl, lastMessage $lastMessage, unreadCounter $unreadCounter,) ';
  }
}
