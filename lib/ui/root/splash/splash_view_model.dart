import 'package:cinespot/data/managers/authentication_manager.dart';
import 'package:flutter/cupertino.dart';

class SplashViewModel extends ChangeNotifier {
  final AuthenticationManager _authManager;

  bool isLoading = true;
  bool isAuthorized = false;

  SplashViewModel(this._authManager);

  Future<void> checkAuthorization() async {
    isLoading = true;
    notifyListeners();

    try {
      isAuthorized = await _authManager.checkUserSession();
    } catch (error) {
      print('Authorization failed: $error');
      isAuthorized = false;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
