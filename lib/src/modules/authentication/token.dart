import 'package:magnific_core/strings/jwt.dart';
import 'package:magnific_core/system/system.dart';

import 'error.dart';

class TokenTypes {
  static const String jwt = 'JWT';
}

abstract class AuthenticationToken {
  const AuthenticationToken._(this.tokenType, this.token);

  factory AuthenticationToken(String tokenType, String token) {
    switch (tokenType) {
      case TokenTypes.jwt:
        return JwtAuthenticationToken(token);
      default:
        throw const AuthenticationError('Invalid authentication token');
    }
  }

  final String tokenType;
  final String token;

  DateTime get expiresAt;
  bool get hasExpired;
  bool get isAuthenticated => !hasExpired;
  Duration get expiresIn;
}

class JwtAuthenticationToken extends AuthenticationToken {
  JwtAuthenticationToken(String token) : super._('JWT', token);

  @override
  DateTime get expiresAt {
    try {
      return JwtDecoder.getExpirationDateTime(token);
    } on FormatException {
      logger.severe('Invalid authorization token: $token');
      return DateTime.now().subtract(const Duration(seconds: 1));
    }
  }

  @override
  Duration get expiresIn {
    try {
      return JwtDecoder.getRemainingTime(token);
    } on FormatException {
      logger.severe('Invalid authorization token: $token');
      return Duration.zero;
    }
  }

  @override
  bool get hasExpired {
    try {
      return JwtDecoder.isExpired(token);
    } on FormatException {
      logger.severe('Invalid authorization token: $token');
      return true;
    }
  }
}
