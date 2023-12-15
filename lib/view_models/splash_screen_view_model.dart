import 'package:flutter/material.dart';
import 'package:participant/services/auth_service.dart';
import 'package:participant/services/locator.dart';

class SplashScreenViewModel extends ChangeNotifier {
  final _authService = locator<AuthService>();

  bool isLoading = false;

  bool get isUserLoggedIn => _authService.isUserLoggedIn;

  Future<void> loadInitialData() async {
    isLoading = true;
    // load any inital data on startup here
    await Future.delayed(
      const Duration(
        seconds: 2,        
      ),
    );

    isLoading = false;
    notifyListeners();
  }
}
