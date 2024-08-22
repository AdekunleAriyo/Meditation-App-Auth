import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_1_portfolio/auth/auth_exceptions.dart';
import 'package:project_1_portfolio/auth/auth_service.dart';
import 'package:project_1_portfolio/constants/routes.dart';
import 'package:project_1_portfolio/dialogs/error_dialog.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late final TextEditingController _email;
  late final TextEditingController _password;
  bool _obscureText = true;
  bool _isLoading = false;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(236, 244, 244, 1),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 5,
              ),
              child: SafeArea(
                child: Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Good to see you!',
                          style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.w400, fontSize: 32),
                        ),
                        Text(
                          'Login to your account',
                          style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.w400, fontSize: 20),
                        ),
                        SizedBox(height: 20),
                        TextField(
                          controller: _email,
                          keyboardType: TextInputType.emailAddress,
                          cursorColor: Colors.grey,
                          decoration: InputDecoration(
                              hintText: 'Email',
                              hintStyle: TextStyle(color: Colors.grey),
                              suffixIcon: Icon(Icons.email),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30))),
                        ),
                        SizedBox(height: 20),
                        TextField(
                          controller: _password,
                          obscureText: _obscureText,
                          keyboardType: TextInputType.emailAddress,
                          cursorColor: Colors.grey,
                          decoration: InputDecoration(
                              hintText: 'Password',
                              hintStyle: TextStyle(color: Colors.grey),
                              suffixIcon: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      _obscureText = !_obscureText;
                                    });
                                  },
                                  icon: Icon(Icons.visibility_off)),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30))),
                        ),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pushNamed(forgotPassword);
                              },
                              child: Text(
                                'Forgot Password?',
                                style: GoogleFonts.montserrat(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                  color: Color(0xFF026666),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        GestureDetector(
                          onTap: () async {
                            setState(() {
                              _isLoading = true;
                            });

                            final email = _email.text.trim();
                            final password = _password.text.trim();
                            try {
                              await AuthService.firebase().login(
                                email: email,
                                password: password,
                              );

                              final user = AuthService.firebase().currentuser;
                              if (user!.isEmailVerified) {
                                Navigator.of(context).pushNamedAndRemoveUntil(
                                    firstPage,
                                    (route) =>
                                        false); // user's email is verified
                              } else {
                                Navigator.of(context).pushNamedAndRemoveUntil(
                                    verifyCode,
                                    (route) => false); // user is not verified.
                              }
                            } on UserNotFoundAuthException {
                              await showErrorDialog(
                                context,
                                'User not found',
                              );
                            } on WrongPasswordAuthException {
                              await showErrorDialog(
                                context,
                                'Wrong credentials',
                              );
                            } on GenericAuthException {
                              await showErrorDialog(
                                context,
                                'Authentication error',
                              );
                            } finally {
                              setState(() {
                                _isLoading = false;
                              });
                            }
                          },
                          child: Container(
                            height: 56,
                            decoration: BoxDecoration(
                                color: Color(0xFF026666),
                                borderRadius: BorderRadius.circular(25)),
                            child: Center(
                              child: Text(
                                'Log In',
                                style: GoogleFonts.montserrat(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Text(
                              "Don't have an account?",
                              style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.w400,
                                fontSize: 16,
                              ),
                            ),
                            TextButton(
                                onPressed: () {
                                  Navigator.pushNamed(context, signupRoute);
                                },
                                child: Text(
                                  'Sign Up',
                                  style: GoogleFonts.montserrat(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 16,
                                      color: Color(0xFF026666)),
                                ))
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          if (_isLoading)
            Center(
                child: CircularProgressIndicator(
              backgroundColor: Color(0xFF026666),
              strokeWidth: 10,
            ))
        ],
      ),
    );
  }
}
