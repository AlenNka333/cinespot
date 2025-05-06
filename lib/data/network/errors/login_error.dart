class LoginError implements Exception {
  final String message;
  LoginError(this.message);

  @override
  String toString() => message;
}
