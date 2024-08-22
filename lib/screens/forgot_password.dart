import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_1_portfolio/constants/routes.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  Color defaultColor = Color(0xFF026666);
  Color onPickedColor = Color(0XFF35A4A4);
  final _emailController = TextEditingController();
  bool isPhoneNumberValid = false;
  bool _isLoading = false;

  Future<void> resetPassword(String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(
        email: _emailController.text.trim(),
      );
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(236, 244, 244, 1),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10),
                  Container(
                      height: 44,
                      width: 44,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: defaultColor),
                      child: IconButton(
                          onPressed: () {
                            Navigator.of(context).pushNamed(loginRoute);
                          },
                          icon: Icon(
                            Icons.chevron_left,
                            color: Colors.white,
                          ))),
                  SizedBox(height: 10),
                  Text(
                    'Forgot Password',
                    style: GoogleFonts.montserrat(
                        fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Please enter a valid e-mail. We will send you a 4 digit code to verify your account.',
                    style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 15),
                  TextField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    cursorColor: Colors.grey,
                    decoration: InputDecoration(
                        hintText: 'Enter e-mail',
                        hintStyle: TextStyle(color: Colors.grey),
                        suffixIcon: Icon(Icons.email),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30))),
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushNamed(loginRoute);
                        },
                        child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: defaultColor),
                            height: 56,
                            width: 160,
                            child: Center(
                              child: Text(
                                'Cancel',
                                style: GoogleFonts.montserrat(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                    color: Colors.white),
                              ),
                            )),
                      ),
                      GestureDetector(
                        onTap: () async {
                          setState(() {
                            _isLoading = true;
                          });

                          final email = _emailController.text.trim();

                          try {
                            await resetPassword(email);

                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                    'Password reset email sent. Please check your inbox.'),
                              ),
                            );
                          } catch (e) {}
                        },
                        child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: defaultColor),
                            height: 56,
                            width: 160,
                            child: Center(
                              child: Text(
                                'Submit',
                                style: GoogleFonts.montserrat(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                    color: Colors.white),
                              ),
                            )),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
