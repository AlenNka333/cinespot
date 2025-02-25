import 'package:cinespot/data/network/api/api_client.dart';
import 'package:cinespot/data/network/models/user.dart';
import 'package:cinespot/data/sources/secure_storage_service.dart';
import 'package:cinespot/data/sources/shared_prefs_service.dart';

class AuthProvider {
  final APIClient apiClient;
  final SecureStorageService secureStorageService;
  final SharedPrefsService sharedPrefsService;

  AuthProvider(
      {required this.apiClient,
      required this.secureStorageService,
      required this.sharedPrefsService});

  Future<User?> login(String username, String password) async {
    final token = await apiClient.createRequestToken();
    if (token == null) return null;

    final validatedToken = await apiClient.validateLogin(
        username: username, password: password, token: token);
    if (validatedToken == null) return null;

    final sessionId =
        await apiClient.createSession(requestToken: validatedToken);
    if (sessionId == null) return null;

    await secureStorageService.saveSessionId(sessionId);

    final User? accountInfo =
        await apiClient.getAccountInfo(sessionId: sessionId);
    if (accountInfo == null) return null;

    await sharedPrefsService.saveUserData(username, accountInfo.accountId);

    return accountInfo;
  }

  Future<User?> checkUserSession() async {
    final sessionId = await secureStorageService.getSessionId();
    if (sessionId != null && sessionId.isNotEmpty) {
      final User? accountInfo =
          await apiClient.getAccountInfo(sessionId: sessionId);
      if (accountInfo == null) return null;
      return accountInfo;
    } else {
      return null;
    }
  }

  Future<User?> getUserInfo({required String sessionId}) async {
    final User? accountInfo =
        await apiClient.getAccountInfo(sessionId: sessionId);
    if (accountInfo == null) return null;

    return accountInfo;
  }

  Future<void> logout() async {
    await secureStorageService.deleteSessionId();
    await sharedPrefsService.clearUserData();
  }
}
