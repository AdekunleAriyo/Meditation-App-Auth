import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_1_portfolio/auth/auth_exceptions.dart';
import 'package:project_1_portfolio/auth/auth_service.dart';
import 'package:project_1_portfolio/constants/routes.dart';
import 'package:project_1_portfolio/dialogs/error_dialog.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool _isLoading = false;
  bool _obscureText = true;
  final _emailcontroller = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _phoneNumberController = TextEditingController();

  @override
  void dispose() {
    _emailcontroller.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _firstNameController.dispose();
    _phoneNumberController.dispose();

    super.dispose();
  }

  Future<void> signUp({required String email, required String password}) async {
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: _emailcontroller.text.trim(),
      password: _passwordController.text.trim(),
    );

    await addUserDetails(
        _firstNameController.text.trim(),
        _emailcontroller.text.trim(),
        int.parse(_phoneNumberController.text.trim()));
  }

  Future addUserDetails(String firstName, String email, int phoneNumber) async {
    try {
      await FirebaseFirestore.instance.collection('users').add({
        'first name ': firstName,
        'Email': email,
        'phone': phoneNumber,
      });
    } catch (e) {
      print('Error adding users to Firestore: $e');
      throw e.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(236, 244, 244, 1),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              child: SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20),
                    Text(
                      'Create an account',
                      style: GoogleFonts.montserrat(
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(height: 20),
                    TextField(
                      controller: _firstNameController,
                      keyboardType: TextInputType.emailAddress,
                      cursorColor: Colors.grey,
                      decoration: InputDecoration(
                          hintText: 'Enter Name',
                          hintStyle: TextStyle(color: Colors.grey),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30))),
                    ),
                    SizedBox(height: 20),
                    TextField(
                      controller: _emailcontroller,
                      keyboardType: TextInputType.emailAddress,
                      cursorColor: Colors.grey,
                      decoration: InputDecoration(
                          hintText: 'Enter Email',
                          hintStyle: TextStyle(color: Colors.grey),
                          suffixIcon: Icon(Icons.email),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30))),
                    ),
                    SizedBox(height: 20),
                    TextField(
                      controller: _phoneNumberController,
                      keyboardType: TextInputType.phone,
                      cursorColor: Colors.grey,
                      decoration: InputDecoration(
                          hintText: 'Enter Phone Number',
                          hintStyle: TextStyle(color: Colors.grey),
                          suffixIcon: Icon(Icons.phone),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30))),
                    ),
                    SizedBox(height: 20),
                    TextField(
                      controller: _passwordController,
                      obscureText: _obscureText,
                      keyboardType: TextInputType.emailAddress,
                      cursorColor: Colors.grey,
                      decoration: InputDecoration(
                          hintText: 'Set Password',
                          hintStyle: TextStyle(color: Colors.grey),
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                _obscureText = !_obscureText;
                              });
                            },
                            icon: Icon(Icons.visibility_off_outlined),
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30))),
                    ),
                    SizedBox(height: 20),
                    TextField(
                      controller: _confirmPasswordController,
                      obscureText: _obscureText,
                      keyboardType: TextInputType.emailAddress,
                      cursorColor: Colors.grey,
                      decoration: InputDecoration(
                          hintText: 'Confirm Password',
                          hintStyle: TextStyle(color: Colors.grey),
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                _obscureText = !_obscureText;
                              });
                            },
                            icon: Icon(Icons.visibility_off_outlined),
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30))),
                    ),
                    SizedBox(height: 30),
                    GestureDetector(
                      onTap: () async {
                        setState(() {
                          _isLoading = true;
                        });

                        final email = _emailcontroller;
                        final password = _passwordController;

                        try {
                          await signUp(
                              email: email.text, password: password.text);
                          AuthService.firebase().currentuser;
                          await AuthService.firebase().sendEmailVerification();
                          Navigator.of(context).pushNamed(VerificationPrompt);
                        } on WeakPasswordAuthException {
                          await showErrorDialog(
                            context,
                            'Weak Password',
                          );
                        } on EmailAlreadyInUseAuthException {
                          await showErrorDialog(
                            context,
                            'email is already in use',
                          );
                        } on InvalidEmailAuthException {
                          await showErrorDialog(
                              context, 'This is an invalid email address');
                        } on GenericAuthException {
                          await showErrorDialog(
                            context,
                            'Failed to register',
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
                            'SIgn Up',
                            style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Row(
                      children: [
                        Text(
                          'Already have an account?',
                          style: GoogleFonts.montserrat(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text(
                              'Log In',
                              style: GoogleFonts.montserrat(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16,
                                  color: Color(0xFF026666)),
                            ))
                      ],
                    )
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
