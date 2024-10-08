import 'package:flutter/material.dart';

@immutable
class AuthUser {
  final bool isEmailVerified;
  final String? email;

  const AuthUser({
    required this.isEmailVerified,
    required this.email,
  });

  factory AuthUser.fromFirebase(User, user) => AuthUser(
        email: user.email,
        isEmailVerified: user.emailVerified,
      );
}
