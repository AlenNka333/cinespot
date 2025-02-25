import 'package:cinespot/data/network/models/user.dart';
import 'package:cinespot/data/providers/auth_provider.dart';
import 'package:flutter/cupertino.dart';

class AuthenticationManager extends ChangeNotifier {
  final AuthProvider authProvider;
  bool isAuthorized = false;
  bool isLoading = false;
  User? account;

  AuthenticationManager({required this.authProvider});

  Future<bool> checkUserSession() async {
    account = await authProvider.checkUserSession();
    isAuthorized = !(account == null);
    return isAuthorized;
  }

  Future<bool> login(
      {required String username, required String password}) async {
    isLoading = true;

    try {
      account = await authProvider.login(username, password);
      isAuthorized = !(account == null);
    } catch (error) {
      print(error.toString());
    } finally {
      isLoading = false;
    }

    return isAuthorized;
  }

  bool logout() {
    authProvider.logout();
    isAuthorized = false;
    account = null;
    return isAuthorized;
  }
}
