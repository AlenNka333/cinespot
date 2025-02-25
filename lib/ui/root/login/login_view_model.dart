import 'package:cinespot/data/managers/authentication_manager.dart';
import 'package:flutter/cupertino.dart';

class LoginViewModel extends ChangeNotifier {
  final AuthenticationManager _authManager;
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool _isPasswordVisible = false;
  bool _isLoading = false;
  bool _isAuthorized = false;
  String? _errorMessage;

  LoginViewModel(this._authManager);

  bool get isPasswordVisible => _isPasswordVisible;
  bool get isLoading => _isLoading;
  bool get isAuthorized => _isAuthorized;
  String? get errorMessage => _errorMessage;

  void togglePasswordVisibility() {
    _isPasswordVisible = !_isPasswordVisible;
    notifyListeners();
  }

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> login() async {
    _isLoading = true;
    notifyListeners();

    try {
      _isAuthorized = await _authManager.login(
        username: usernameController.text,
        password: passwordController.text,
      );
      notifyListeners();
    } catch (error) {
      _errorMessage = 'Authorization failed: $error';
      _isAuthorized = false;
      notifyListeners();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
