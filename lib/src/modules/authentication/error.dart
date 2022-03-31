class AuthenticationError {
  final String message;

  const AuthenticationError(this.message);

  @override
  String toString() {
    return 'AuthenticationError($message)';
  }
}
