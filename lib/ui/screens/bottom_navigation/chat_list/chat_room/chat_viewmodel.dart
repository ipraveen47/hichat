import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hichat/core/models/message_model.dart';
import 'package:hichat/core/models/user_model.dart';
import 'package:hichat/core/other/base_view_model.dart';
import 'package:hichat/core/services/chat_service.dart';

class ChatViewmodel extends BaseViewModel {
  final ChatService _chatService;
  final UserModel _currentUser;
  final UserModel _receiver;

  StreamSubscription? _subscription;

  ChatViewmodel(this._chatService, this._currentUser, this._receiver) {
    getChatRoom();

    _subscription = _chatService.getMessages(chatRoomId).listen((messages) {
      _messages = messages.docs.map((e) => Message.fromMap(e.data())).toList();
      notifyListeners();
    });
  }

  String chatRoomId = "";

  final _messageController = TextEditingController();

  TextEditingController get controller => _messageController;

  List<Message> _messages = [];

  List<Message> get messages => _messages;

  getChatRoom() {
    if (_currentUser.uid.hashCode > _receiver.uid.hashCode) {
      chatRoomId = "${_currentUser.uid}_${_receiver.uid}";
    } else {
      chatRoomId = "${_receiver.uid}_${_currentUser.uid}";
    }
  }

  saveMessage() async {
    log("Send Message");
    try {
      if (_messageController.text.isEmpty) {
        throw Exception("Please enter some text");
      }
      final now = DateTime.now();

      final message = Message(
          id: now.millisecondsSinceEpoch.toString(),
          content: _messageController.text,
          senderId: _currentUser.uid,
          recieverId: _receiver.uid,
          timestamp: now);

      await _chatService.saveMessage(message.toMap(), chatRoomId);

      _chatService.updateLastMessage(_currentUser.uid!, _receiver.uid!,
          message.content!, now.millisecondsSinceEpoch);

      _messageController.clear();
    } catch (e) {
      rethrow;
    }
  }

  @override
  void dispose() {
    super.dispose();

    _subscription?.cancel();
  }
}
