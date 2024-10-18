import 'package:flutter/material.dart';
import 'welcome_screen2.dart';
import 'package:google_fonts/google_fonts.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            // Container untuk logo di bagian atas
            Align(
              alignment: const Alignment(0.0, -0.85),
              child: Image.asset(
                'assets/images/logoaplikasir.jpg',
                width: 153,
                height: 53,
              ),
            ),
            // Container untuk gambar utama
            Align(
              alignment: const Alignment(-40, 0),
              child: Image.asset(
                'assets/images/logoawal.jpg',
                width: 430,
                height: 477,
              ),
            ),
            // Container untuk teks Selamat Datang
            Align(
              alignment: const Alignment(-0.75, 0.87),
              child: Text(
                "Selamat Datang",
                style: GoogleFonts.poppins(
                  color: colorPrimary,
                  fontSize: 25,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            // Container untuk tombol di pojok kanan bawah
            Align(
              alignment: const Alignment(0.95, 0.91),
              child: GestureDetector(
                onTap: () {
                  _navigateToWelcomeScreen(context);
                },
                child: Image.asset(
                  'assets/icons/firstbutton.png',
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
  
  void _navigateToWelcomeScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const WelcomeScreen2(),
      ),
    );
  }
}
