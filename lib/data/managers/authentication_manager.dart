import 'package:cinespot/data/network/errors/login_error.dart';
import 'package:cinespot/data/network/models/user.dart';
import 'package:cinespot/data/providers/auth_provider.dart';
import 'package:flutter/cupertino.dart';

class AuthenticationManager extends ChangeNotifier {
  final AuthProvider authProvider;
  bool isAuthorized = false;
  User? account;

  AuthenticationManager({required this.authProvider});

  Future<bool> checkUserSession() async {
    account = await authProvider.checkUserSession();
    isAuthorized = !(account == null);
    return isAuthorized;
  }

  Future<void> login(
      {required String username, required String password}) async {
    try {
      account = await authProvider.login(username, password);
      if (account == null) {
        throw LoginError('There is no such account in databse');
      }
    } catch (error) {
      rethrow;
    }
  }

  bool logout() {
    authProvider.logout();
    isAuthorized = false;
    account = null;
    return isAuthorized;
  }
}
