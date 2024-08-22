import 'package:flutter/material.dart';
import 'package:project_1_portfolio/auth/auth_service.dart';
import 'package:project_1_portfolio/constants/routes.dart';
import 'package:project_1_portfolio/screens/first_page.dart';
import 'package:project_1_portfolio/screens/forgot_password.dart';
import 'package:project_1_portfolio/screens/login_page.dart';
import 'package:project_1_portfolio/screens/signup.dart';
import 'package:project_1_portfolio/screens/splash_screen.dart';
import 'package:project_1_portfolio/screens/verification_prompt.dart';
import 'package:project_1_portfolio/screens/verify_code.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Meditation App',
      home: SplashScreen(),
      debugShowCheckedModeBanner: false,
      routes: {
        signupRoute: (context) => SignUp(),
        loginRoute: (context) => LoginPage(),
        forgotPassword: (context) => ForgotPassword(),
        verifyCode: (context) => VerifyCode(),
        firstPage: (context) => FirstPage(),
        VerificationPrompt: (context) => Verification_Prompt(),
      },
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: AuthService.firebase().initialize(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              final user = AuthService.firebase().currentuser;
              if (user != null) {
                if (user.isEmailVerified) {
                  return FirstPage();
                } else {
                  return const Verification_Prompt();
                }
              } else {
                return LoginPage();
              }
            default:
              return CircularProgressIndicator();
          }
        });
  }
}
