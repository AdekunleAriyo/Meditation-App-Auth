import 'package:project_1_portfolio/auth/auth_provider.dart';
import 'package:project_1_portfolio/auth/auth_user.dart';
import 'firebase_auth_provider..dart';

class AuthService implements AuthProvider {
  final AuthProvider provider;

  AuthService(this.provider);

  factory AuthService.firebase() => AuthService(FirebaseAuthProvider());

  @override
  // Future<AuthUser> CreateUser({
  //   required String email,
  //   required String password,
  // }) =>
  //     provider.CreateUser(
  //       email: email,
  //       password: password,
  //     );

  @override
  // TODO: implement currentuser
  AuthUser? get currentuser => provider.currentuser;

  @override
  Future<void> logOut() => provider.logOut();

  @override
  Future<AuthUser> login({
    required String email,
    required String password,
  }) =>
      provider.login(
        email: email,
        password: password,
      );
  @override
  Future<void> sendEmailVerification() => provider.sendEmailVerification();

  @override
  Future<void> initialize() => provider.initialize();
}
