import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:aplikasir/screen/homepage.dart';
import 'package:aplikasir/screen/signup_screen.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';

class SignInScreen extends StatefulWidget {
  final String? username;
  final String? password;

  const SignInScreen({Key? key, this.username, this.password}) : super(key: key);
  
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final CollectionReference users = FirebaseFirestore.instance.collection('users');

  @override
  void initState() {
    super.initState();
    if (widget.username != null) {
      _usernameController.text = widget.username!;
    }
    if (widget.password != null) {
      _passwordController.text = widget.password!;
    }
  }

  String _hashPassword(String password) {
    final bytes = utf8.encode(password);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  Future<void> _signIn() async {
    final String username = _usernameController.text.trim();
    final String password = _passwordController.text.trim();
    String hashedPassword = _hashPassword(password);

    try {
      // Query the user based on username and password
      final QuerySnapshot result = await users
          .where('username', isEqualTo: username)
          .where('password', isEqualTo: hashedPassword)
          .get();

      if (result.docs.isNotEmpty) {
        final String userId = result.docs[0].id;

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HomePage(),
          ),
        );
      } else {
        _showErrorDialog("Username atau password salah!");
      }
    } catch (e) {
      _showErrorDialog("Terjadi kesalahan. Silakan coba lagi.");
    }
  }

  // Function to display error dialog
  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Error',
            style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
          ),
          content: Text(message, style: GoogleFonts.poppins()),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK', style: GoogleFonts.poppins()),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 80),
              Center(
                child: Text(
                  'Masuk',
                  style: GoogleFonts.poppins(
                    color: colorPrimary,
                    fontSize: 30,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(height: 50),
              Text(
                'Ayo lengkapi data dirimu',
                style: GoogleFonts.poppins(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 20),
              _buildTextField(
                'Username',
                'Masukkan Username',
                controller: _usernameController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Username tidak boleh kosong';
                  }
                  return null;
                },
              ),
              _buildTextField(
                'Kata Sandi',
                'Masukkan kata sandi',
                controller: _passwordController,
                obscureText: true,
                validator: (value) {
                  if (value!.isEmpty || value.length < 6) {
                    return 'Password minimal 6 karakter';
                  }
                  return null;
                },
              ),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    // Logika buat lupa kata sandi males ngisi
                  },
                  child: Text(
                    'Lupa Kata Sandi?',
                    style: GoogleFonts.poppins(
                      color: colorPrimary,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),

              const Spacer(),

              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _signIn,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: colorPrimary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    'Masuk',
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 10),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Belum memiliki akun?',
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: Colors.black,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SignUpScreen(),
                        ),
                      );
                    },
                    child: Text(
                      'Daftar',
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        color: colorPrimary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 60),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
    String label, 
    String hint, 
    {required TextEditingController controller, bool obscureText = false, String? Function(String?)? validator}
    ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.poppins(
            color: Colors.black,
            fontSize: 15,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          obscureText: obscureText,
          validator: validator,
          decoration: InputDecoration(
            hintText: hint,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            suffixIcon: obscureText ? const Icon(Icons.visibility_off) : null,
          ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }

  static const colorPrimary = Color.fromRGBO(40, 109, 225, 1);
}
