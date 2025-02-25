import 'package:cinespot/data/managers/authentication_manager.dart';
import 'package:cinespot/ui/common/navigation/router.dart';
import 'package:flutter/cupertino.dart';

class ProfileViewModel extends ChangeNotifier {
  final AuthenticationManager _authManager;

  bool isAuthorized = false;

  ProfileViewModel(this._authManager);

  void logout(BuildContext context) {
    isAuthorized = _authManager.logout();
    notifyListeners();

    if (!isAuthorized) {
      Navigator.of(context, rootNavigator: true)
          .pushReplacementNamed(AppRouter.loginPage);
    }
  }
}
