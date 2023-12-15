import 'package:flutter/material.dart';
import 'package:participant/services/auth_service.dart';
import 'package:participant/services/locator.dart';

class LoginScreenViewModel extends ChangeNotifier {
  final _authService = locator<AuthService>();

  TextEditingController _usernameTextFieldController = TextEditingController();
  TextEditingController _passwordTextFieldController = TextEditingController();

  TextEditingController get usernameTextFieldController => _usernameTextFieldController;
  TextEditingController get passwordTextFieldController => _passwordTextFieldController;

  String? errorMessage;

  set usernameTextFieldController(TextEditingController value) {
    _usernameTextFieldController = value;
    notifyListeners();
  }

  set passwordTextFieldController(TextEditingController value) {
    _passwordTextFieldController = value;
    notifyListeners();
  }

  bool handelLoginCta() {
    errorMessage = null;

    final isSuccess = _authService.userAuth(
      username: _usernameTextFieldController.text.trim(),
      password: _passwordTextFieldController.text.trim(),
    );

    if (!isSuccess) {
      errorMessage = 'Check Username and Password, Try Again!';
      notifyListeners();
      return false;
    }

    return true;
  }
}
