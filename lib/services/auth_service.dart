class AuthService {
  static const embeddedUserName = 'mike12';
  static const embeddedPassword = 'Test1234!';

  bool _isUserLoggedIn = false;

  // ignore: unnecessary_getters_setters
  bool get isUserLoggedIn => _isUserLoggedIn;

  set isUserLoggedIn(bool value) {
    _isUserLoggedIn = value;
  }

  bool userAuth({
    required String username,
    required String password,
  }) {
    final uName = username.toLowerCase();
    if (uName == embeddedUserName && password == embeddedPassword) {
      _isUserLoggedIn = true;
      return true;
    }

    return false;
  }

  void logout() {
    _isUserLoggedIn = false;
  }
}
