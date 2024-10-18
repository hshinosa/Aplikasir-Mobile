import 'package:aplikasir/screen/homepage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TambahProduk extends StatefulWidget {
  const TambahProduk({super.key});

  @override
  State<TambahProduk> createState() => _TambahProdukState();
}

class _TambahProdukState extends State<TambahProduk> {
  // TextEditingController untuk tiap field
  final TextEditingController _namaProdukController = TextEditingController();
  final TextEditingController _kodeProdukController = TextEditingController();
  final TextEditingController _jumlahProdukController = TextEditingController();
  final TextEditingController _hargaModalController = TextEditingController();
  final TextEditingController _hargaJualController = TextEditingController();

  // Fungsi untuk menyimpan data
  void _simpanData() {
    String namaProduk = _namaProdukController.text;
    String kodeProduk = _kodeProdukController.text;
    String jumlahProduk = _jumlahProdukController.text;
    String hargaModal = _hargaModalController.text;
    String hargaJual = _hargaJualController.text;

    // Lakukan penyimpanan atau pengolahan data sesuai kebutuhan, misalnya simpan ke database atau kirim ke API
    print('Nama Produk: $namaProduk');
    print('Kode Produk: $kodeProduk');
    print('Jumlah Produk: $jumlahProduk');
    print('Harga Modal: $hargaModal');
    print('Harga Jual: $hargaJual');

    // Setelah menyimpan data, bisa navigasi kembali atau menampilkan pesan sukses
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => HomePage(initialPageIndex: 1),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }


  // Builder untuk membuat TextField
  Widget _buildTextField(
      {required String label,
        required String hintText,
        required TextEditingController controller}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        TextField(
          controller: controller,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: GoogleFonts.poppins(fontSize: 16),
            border: OutlineInputBorder(),
            contentPadding: EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 10,
            ),
          ),
        ),
        SizedBox(height: 10),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Tambah Produk',
          style: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true, // Agar judul berada di tengah
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Kembali ke screen sebelumnya
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  height: 137,
                  width: 257,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.add, size: 50, color: Colors.grey),
                        Text(
                          'Masukkan Gambar Produk',
                          style: GoogleFonts.poppins(fontSize: 16, color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),
              _buildTextField(
                label: 'Nama Produk',
                hintText: 'Masukkan Nama Produk',
                controller: _namaProdukController,
              ),
              _buildTextField(
                label: 'Kode Produk',
                hintText: 'Masukkan Kode Produk',
                controller: _kodeProdukController,
              ),
              _buildTextField(
                label: 'Jumlah Produk',
                hintText: 'Masukkan Jumlah Produk',
                controller: _jumlahProdukController,
              ),
              _buildTextField(
                label: 'Harga Modal',
                hintText: 'Masukkan Harga Modal',
                controller: _hargaModalController,
              ),
              _buildTextField(
                label: 'Harga Jual',
                hintText: 'Masukkan Harga Jual',
                controller: _hargaJualController,
              ),
              SizedBox(height: 15),
              SizedBox(
                width: 370,
                height: 40,
                child: ElevatedButton(
                  child: Text(
                    'Simpan',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: EdgeInsets.zero, // Menghapus padding vertikal
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  onPressed: _simpanData, // Simpan data saat tombol ditekan
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
