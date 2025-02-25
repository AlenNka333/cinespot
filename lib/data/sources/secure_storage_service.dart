import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageService {
  final _storage = FlutterSecureStorage();

  Future<void> saveSessionId(String sessionId) async {
    await _storage.write(key: 'session_id', value: sessionId);
  }

  Future<String?> getSessionId() async {
    return await _storage.read(key: 'session_id');
  }

  Future<void> deleteSessionId() async {
    await _storage.delete(key: 'session_id');
  }
}
