import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_1_portfolio/constants/routes.dart';

class PasswordSent extends StatelessWidget {
  const PasswordSent({super.key});

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
                'Check your inbox',
                style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.w600, fontSize: 24),
              ),
              SizedBox(height: 10),
              Text(
                'Your new Password has been sent to your phone',
                style: GoogleFonts.montserrat(
                    fontSize: 16, fontWeight: FontWeight.w400),
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
                      'Log In',
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
