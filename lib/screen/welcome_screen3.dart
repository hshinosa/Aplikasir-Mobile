import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:aplikasir/screen/signin_screen.dart';

class WelcomeScreen3 extends StatelessWidget {
  const WelcomeScreen3({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            // Logo di bagian atas
            Align(
              alignment: const Alignment(0.0, -0.85),
              child: Image.asset(
                'assets/images/logoaplikasir.jpg',
                width: 153,
                height: 53,
              ),
            ),
            
            Align(
              alignment: const Alignment(0.0, -0.4),
              child: Image.asset(
                'assets/images/logotiga.png',
                width: 300,
                height: 200,
              ),
            ),
            
            Align(
              alignment: const Alignment(-0.1, 0.2),
              child: Text(
                "Mengelola pendapatanmu\ndengan mudah",
                textAlign: TextAlign.left,
                style: GoogleFonts.poppins(
                  color: colorPrimary,
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            
            Align(
              alignment: const Alignment(-0.38, 0.45),
              child: Text(
                "Aplikasir adalah pilihan tepat dan\nterpercaya untuk anda mengelola\nkeuangan usaha anda dengan\nlebih mudah",
                textAlign: TextAlign.left,
                style: GoogleFonts.poppins(
                  color: Colors.blue,
                  fontSize: 16,
                ),
              ),
            ),
            
            Align(
              alignment: const Alignment(0.95, 0.91),
              child: GestureDetector(
                onTap: () {
                  _navigateToSigninScreen(context);
                },
                child: Image.asset(
                  'assets/icons/thirdbutton.png',
                  width: 80,
                  height: 80,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  static const colorPrimary = Color.fromRGBO(40, 109, 225, 1);

  void _navigateToSigninScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SignInScreen(),
      ),
    );
  }
}
