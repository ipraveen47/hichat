import 'package:flutter/material.dart';
import 'package:hichat/core/enum/enum.dart';

class BaseViewModel extends ChangeNotifier {
  ViewState _state = ViewState.idle;
  ViewState get state => _state;

  setState(ViewState state) {
    _state = state;
    notifyListeners();
  }
}
