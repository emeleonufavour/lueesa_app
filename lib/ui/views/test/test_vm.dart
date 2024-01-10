import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class TestViewModel extends BaseViewModel {
  bool _touched = false;
  bool _show = false;
  Offset? _boxPosition;
  Offset? _secBoxPosition;

  bool get touched => _touched;
  bool get show => _show;
  Offset? get boxPosition => _boxPosition;
  Offset? get secBoxPosition => _secBoxPosition;

  set touched(bool value) {
    _touched = value;
    notifyListeners();
  }

  set show(bool value) {
    _show = value;
    notifyListeners();
  }

  set boxPosition(Offset? value) {
    _boxPosition = value;
    notifyListeners();
  }

  set secBoxPosition(Offset? value) {
    _secBoxPosition = value;
    notifyListeners();
  }
}
