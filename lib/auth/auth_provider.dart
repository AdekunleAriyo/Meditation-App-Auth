import 'package:project_1_portfolio/auth/auth_user.dart';

abstract class AuthProvider {
  AuthUser? get currentuser;
  Future<void> initialize();
  Future<AuthUser> login({
    required String email,
    required String password,
  });
  // Future<AuthUser> CreateUser({
  //   required String email,
  //   required String password,

  // });

  Future<void> logOut();

  Future<void> sendEmailVerification();
}
