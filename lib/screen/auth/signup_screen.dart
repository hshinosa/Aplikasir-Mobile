import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:aplikasir/screen/auth/signin_screen.dart';
import 'package:aplikasir/api/auth_api.dart'; // Import API

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final PageController _pageController = PageController();
  final _formKeyPage1 = GlobalKey<FormState>();
  final _formKeyPage2 = GlobalKey<FormState>();

  // Controllers untuk setiap field
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _shopNameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  // Fungsi untuk pindah ke halaman kedua dengan validasi
  void _goToNextPage() {
    if (_formKeyPage1.currentState!.validate()) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  // Fungsi untuk kembali ke halaman pertama
  void _goToPreviousPage() {
    _pageController.previousPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  // Fungsi untuk mendaftarkan user
  Future<void> _registerUser() async {
    if (_formKeyPage2.currentState!.validate()) {
      print("Form valid, mulai proses register...");
      try {
        // Panggil API registerPengguna
        print("Mengirim data ke API...");
        final response = await AuthAPI.registerPengguna(
          username: _usernameController.text.trim(),
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
          name: _nameController.text.trim(),
          phone: _phoneController.text.trim(),
          shopName: _shopNameController.text.trim(),
          address: _addressController.text.trim(),
        );

        // Debug response dari API
        print("Response dari API: $response");

        // Cek apakah pendaftaran berhasil
        if (response['status'] == 'success') {
          print("Pendaftaran berhasil!");
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Pendaftaran berhasil!')),
          );
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => SignInScreen(
                username: _usernameController.text.trim(),
                password: _passwordController.text.trim(),
              ),
            ),
          );
        } else {
          print("Gagal mendaftarkan user: ${response['message']}");
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Gagal: ${response['message']}')),
          );
        }
      } catch (e) {
        print("Terjadi kesalahan: ${e.toString()}");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Gagal mendaftarkan user: ${e.toString()}')),
        );
      }
    } else {
      print("Form tidak valid.");
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: PageView(
            controller: _pageController,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              _buildFirstPage(),
              _buildSecondPage(),
            ],
          ),
        ),
      ),
    );
  }

  // Form pertama (untuk username, email, password)
  Widget _buildFirstPage() {
    return Form(
      key: _formKeyPage1,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 45),
          Center(
            child: Text(
              'Daftar',
              style: GoogleFonts.poppins(
                color: colorPrimary,
                fontSize: 30,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 20),
            alignment: Alignment.centerLeft,
            child: Center(
              child: Text(
                'Ayo Lengkapi data dirimu untuk menggunakan ApliKasir',
                style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: ListView(
              children: [
                _buildTextField(
                  'Username',
                  'Masukkan Username',
                  controller: _usernameController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Username tidak boleh kosong';
                    }
                    return null;
                  },
                ),
                _buildTextField(
                  'Email',
                  'Masukkan Email',
                  controller: _emailController,
                  validator: (value) {
                    if (value == null || !value.contains('@')) {
                      return 'Masukkan email yang valid';
                    }
                    return null;
                  },
                ),
                _buildTextField(
                  'Kata Sandi',
                  'Masukkan Kata Sandi',
                  controller: _passwordController,
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.length < 6) {
                      return 'Password minimal 6 karakter';
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          _buildNextButton('Lanjut', _goToNextPage),
          const SizedBox(height: 10),
          _buildSignInOption(),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildSecondPage() {
    return Form(
      key: _formKeyPage2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 40),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back, color: colorPrimary),
                onPressed: _goToPreviousPage,
              ),
              const SizedBox(width: 8),
              Text(
                'Daftar',
                style: GoogleFonts.poppins(
                  color: colorPrimary,
                  fontSize: 30,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          Container(
            margin: const EdgeInsets.only(top: 20),
            alignment: Alignment.centerLeft,
            child: Center(
              child: Text(
                'Ayo Lengkapi data dirimu untuk menggunakan ApliKasir',
                style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: ListView(
              children: [
                _buildTextField(
                  'Nama',
                  'Masukkan Nama',
                  controller: _nameController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Nama tidak boleh kosong';
                    }
                    return null;
                  },
                ),
                _buildTextField(
                  'Nomor Telepon',
                  'Masukkan Nomor Telepon',
                  controller: _phoneController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Nomor telepon tidak boleh kosong';
                    }
                    return null;
                  },
                ),
                _buildTextField(
                  'Nama Toko',
                  'Masukkan Nama Toko',
                  controller: _shopNameController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Nama toko tidak boleh kosong';
                    }
                    return null;
                  },
                ),
                _buildTextField(
                  'Alamat Toko',
                  'Masukkan Alamat Toko',
                  controller: _addressController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Alamat toko tidak boleh kosong';
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          _buildNextButton('Daftar', _registerUser),
          const SizedBox(height: 10),
          _buildSignInOption(),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildTextField(
    String label,
    String hint, {
    required TextEditingController controller,
    bool obscureText = false,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: GoogleFonts.poppins(fontSize: 15)),
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
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildNextButton(String text, VoidCallback onPressed) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: colorPrimary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: Text(text, style: GoogleFonts.poppins(color: Colors.white, fontSize: 16)),
      ),
    );
  }

  Widget _buildSignInOption() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Sudah memiliki akun? ', style: GoogleFonts.poppins(fontSize: 14)),
        GestureDetector(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => const SignInScreen()));
          },
          child: Text(
            'Masuk',
            style: GoogleFonts.poppins(fontSize: 14, color: colorPrimary, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }

  static const colorPrimary = Color.fromRGBO(40, 109, 225, 1);
}
