import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Akun extends StatelessWidget {
  final String userId;
  

  const Akun({Key? key, required this.userId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Warna latar belakang putih
      appBar: AppBar(
        title: Text(
          'Profil',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: Colors.black, // Ubah warna teks ke hitam
          ),
        ),
        backgroundColor: Colors.white, // Warna AppBar putih
        elevation: 0, // Hilangkan bayangan AppBar
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          SizedBox(height: 20),
          // Foto profil di kiri dan teks di kanan
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundImage: AssetImage('assets/images/profile_pic.png'), // Sesuaikan path gambar
                ),
                SizedBox(width: 20), // Jarak antara foto profil dan teks
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Aan Suhendar',
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.black, // Sesuaikan warna teks
                      ),
                    ),
                    Text(
                      'Pemilik',
                      style: GoogleFonts.poppins(
                        color: Colors.grey,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 30),
          _buildProfileDetail('assets/icons/user_icon.png', 'Nama Pengguna', 'Aan suhendar'),
          _buildProfileDetail('assets/icons/notelp_icon.png', 'Nomor Telepon', '+6285322009'),
          _buildProfileDetail('assets/icons/store_icon.png', 'Nama Toko', 'Berkah jaya'),
          SizedBox(height: 30),
          Spacer(),
          SizedBox(
            width: 370,
            height: 50,
            child: ElevatedButton(
              onPressed: () {
                // Logika untuk tombol keluar
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                padding: EdgeInsets.zero, // Menghapus padding vertikal
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                'Keluar',
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ),
          ),
          SizedBox(height: 20), // Tambahkan jarak di bawah tombol
        ],
      ),
    );
  }

  Widget _buildProfileDetail(String imagePath, String title, String value) {
    return Column(
      children: [
        Divider( // Garis warna abu di atas setiap detail profil
          color: Colors.grey[300], // Sesuaikan warna garis
          thickness: 1,
          indent: 20, // Jarak indentasi dari kiri
          endIndent: 20, // Jarak indentasi dari kanan
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Row(
            children: [
              Image.asset(
                imagePath,
                width: 50, // Sesuaikan ukuran gambar
                height: 50, // Berikan warna biru pada ikon agar sesuai
              ),
              SizedBox(width: 15), // Sesuaikan jarak antar ikon dan teks
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                  Text(
                    value, // Ubah teks sesuai
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
