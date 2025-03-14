import 'dart:convert';

class Message {
  final String? id;
  final String? content;
  final String? senderId;
  final String? recieverId;
  final DateTime? timestamp;

  Message({
    this.id,
    this.content,
    this.recieverId,
    this.senderId,
    this.timestamp,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'content': content,
      'recieverId': recieverId, // Fixed typo
      'senderId': senderId,
      'timestamp': timestamp?.millisecondsSinceEpoch, // Save as int
    };
  }

  factory Message.fromMap(Map<String, dynamic> map) {
    return Message(
      id: map['id'] as String?,
      content: map['content'] as String?,
      recieverId: map['recieverId'] as String?, // Fixed inconsistency
      senderId: map['senderId'] as String?,
      timestamp: map['timestamp'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['timestamp'] as int)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Message.fromJson(String source) =>
      Message.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Message(id: $id, content: $content, senderId: $senderId, recieverId: $recieverId, timestamp: $timestamp)';
  }
}
