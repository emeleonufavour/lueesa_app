import 'package:stacked/stacked.dart';

class UserService with ListenableServiceMixin {
  final ReactiveValue<bool> _isLoggedIn = ReactiveValue<bool>(false);

  bool get isLoggedIn => _isLoggedIn.value;

  set isLoggedIn(bool value) {
    _isLoggedIn.value = value;
    notifyListeners();
  }
}
