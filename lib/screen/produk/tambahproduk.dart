import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:aplikasir/screen/home/homepage.dart';

class TambahProduk extends StatefulWidget {
  final String userId;

  const TambahProduk({Key? key, required this.userId}) : super(key: key);

  @override
  State<TambahProduk> createState() => _TambahProdukState();
}

class _TambahProdukState extends State<TambahProduk> {
  final TextEditingController _namaProdukController = TextEditingController();
  final TextEditingController _kodeProdukController = TextEditingController();
  final TextEditingController _jumlahProdukController = TextEditingController();
  final TextEditingController _hargaModalController = TextEditingController();
  final TextEditingController _hargaJualController = TextEditingController();

  File? _selectedImage; // File gambar yang dipilih
  final ImagePicker _picker = ImagePicker();

  // Fungsi untuk memilih gambar dari galeri
  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  // Fungsi untuk mengunggah gambar ke Firebase Storage dan mendapatkan URL-nya
  Future<String?> _uploadImageToStorage(File image) async {
    try {
      final fileName = '${DateTime.now().millisecondsSinceEpoch}.jpg';
      final ref = FirebaseStorage.instance
          .ref()
          .child('product_images')
          .child(fileName);

      await ref.putFile(image);
      return await ref.getDownloadURL();
    } catch (e) {
      print('Error uploading image: $e');
      return null;
    }
  }

  // Fungsi untuk menyimpan data produk ke Firestore
  Future<void> _simpanData() async {
    if (_selectedImage == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Harap pilih gambar produk terlebih dahulu!')),
      );
      return;
    }

    try {
      // Upload gambar ke Firebase Storage
      final imageUrl = await _uploadImageToStorage(_selectedImage!);
      if (imageUrl == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Gagal mengunggah gambar.')),
        );
        return;
      }

      // Simpan data produk ke subkoleksi `products` di dalam dokumen pengguna
      final productData = {
        'name': _namaProdukController.text,
        'code': _kodeProdukController.text,
        'quantity': int.parse(_jumlahProdukController.text),
        'costPrice': double.parse(_hargaModalController.text),
        'sellPrice': double.parse(_hargaJualController.text),
        'imagePath': imageUrl,
        'createdAt': FieldValue.serverTimestamp(),
      };

      await FirebaseFirestore.instance
          .collection('users')
          .doc(widget.userId)
          .collection('products')
          .add(productData);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Produk berhasil ditambahkan!')),
      );

      // Navigasikan kembali ke halaman HomePage
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HomePage(userId: widget.userId, initialPageIndex: 1),
        ),
      );
    } catch (e) {
      print('Error saving product: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Gagal menyimpan produk.')),
      );
    }
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
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
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
                child: GestureDetector(
                  onTap: _pickImage,
                  child: Container(
                    height: 137,
                    width: 257,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: _selectedImage != null
                        ? Image.file(
                            _selectedImage!,
                            fit: BoxFit.cover,
                          )
                        : Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.add, size: 50, color: Colors.grey),
                                Text(
                                  'Masukkan Gambar Produk',
                                  style: GoogleFonts.poppins(
                                    fontSize: 16,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
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
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  onPressed: _simpanData,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required String hintText,
    required TextEditingController controller,
  }) {
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
            contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          ),
        ),
        SizedBox(height: 10),
      ],
    );
  }
}
