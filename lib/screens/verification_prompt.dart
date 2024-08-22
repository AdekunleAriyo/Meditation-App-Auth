import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_1_portfolio/constants/routes.dart';

class Verification_Prompt extends StatelessWidget {
  const Verification_Prompt({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(236, 244, 244, 1),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        child: SafeArea(
          child: Column(
            children: [
              SizedBox(height: 250),
              Text(
                'Check your inbox to verify',
                style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.w400, fontSize: 24),
              ),
              Text(
                'your email,',
                style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.w400, fontSize: 24),
              ),
              Text(
                'Sign up again if link has expired.',
                style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.w300, fontSize: 16),
              ),
              SizedBox(height: 40),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed(loginRoute);
                },
                child: Container(
                  height: 56,
                  decoration: BoxDecoration(
                      color: Color(0xFF026666),
                      borderRadius: BorderRadius.circular(25)),
                  child: Center(
                    child: Text(
                      'Go to Log In',
                      style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                          color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
