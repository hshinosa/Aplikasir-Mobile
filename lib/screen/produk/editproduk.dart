import 'package:aplikasir/screen/home/homepage.dart';
import 'package:flutter/material.dart';
import 'package:aplikasir/api/produk_API.dart';
import 'package:aplikasir/models/produk_model.dart';
import 'package:image_picker/image_picker.dart'; // Untuk mengambil gambar
import 'dart:io';

class EditProduk extends StatefulWidget {
  final int userId;
  final ProdukModel produk;

  const EditProduk({Key? key, required this.userId, required this.produk}) : super(key: key);

  @override
  State<EditProduk> createState() => _EditProdukState();
}

class _EditProdukState extends State<EditProduk> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _namaProdukController;
  late TextEditingController _kodeProdukController;
  late TextEditingController _jumlahProdukController;
  late TextEditingController _hargaModalController;
  late TextEditingController _hargaJualController;
  File? _gambarProduk;

  @override
  void initState() {
    super.initState();
    _namaProdukController = TextEditingController(text: widget.produk.namaProduk);
    _kodeProdukController = TextEditingController(text: widget.produk.kodeProduk);
    _jumlahProdukController = TextEditingController(text: widget.produk.jumlahProduk.toString());
    _hargaModalController = TextEditingController(text: widget.produk.hargaModal.toString());
    _hargaJualController = TextEditingController(text: widget.produk.hargaJual.toString());
  }

  @override
  void dispose() {
    _namaProdukController.dispose();
    _kodeProdukController.dispose();
    _jumlahProdukController.dispose();
    _hargaModalController.dispose();
    _hargaJualController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        _gambarProduk = File(image.path);
      });
    }
  }

  Future<void> _simpanData(
    int idProduk,
    String namaProduk,
    String kodeProduk,
    int jumlahProduk,
    String hargaModal,
    String hargaJual,
    File? gambarProduk) async {
  try {
    bool status = await ProdukApi().updateProduk(
      idProduk,
      namaProduk,
      kodeProduk,
      jumlahProduk,
      hargaModal,
      hargaJual,
      gambarProduk,
    );

    if (status) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Produk berhasil diperbarui!')),
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) =>
              HomePage(userId: widget.userId, initialPageIndex: 1),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Gagal memperbarui produk!')),
      );
    }
  } catch (e) {
    print('Error saving product: $e');
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Terjadi kesalahan saat menyimpan data.')),
    );
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(245, 245, 245, 1),
        title: Center(
          child: Text(
            "Edit Produk",
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 22),
          ),
        ),
        automaticallyImplyLeading: true,
      ),
      backgroundColor: Color.fromRGBO(245, 245, 245, 1),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Input Nama Produk
                TextFormField(
                  controller: _namaProdukController,
                  decoration: InputDecoration(labelText: 'Nama Produk'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Nama produk tidak boleh kosong';
                    }
                    return null;
                  },
                ),
                // Input Kode Produk
                TextFormField(
                  controller: _kodeProdukController,
                  decoration: InputDecoration(labelText: 'Kode Produk'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Kode produk tidak boleh kosong';
                    }
                    return null;
                  },
                ),
                // Input Jumlah Produk
                TextFormField(
                  controller: _jumlahProdukController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(labelText: 'Jumlah Produk'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Jumlah produk tidak boleh kosong';
                    }
                    if (int.tryParse(value) == null) {
                      return 'Harap masukkan jumlah produk yang valid';
                    }
                    return null;
                  },
                ),
                // Input Harga Modal
                TextFormField(
                  controller: _hargaModalController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(labelText: 'Harga Modal'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Harga modal tidak boleh kosong';
                    }
                    if (double.tryParse(value) == null) {
                      return 'Harap masukkan harga modal yang valid';
                    }
                    return null;
                  },
                ),
                // Input Harga Jual
                TextFormField(
                  controller: _hargaJualController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(labelText: 'Harga Jual'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Harga jual tidak boleh kosong';
                    }
                    if (double.tryParse(value) == null) {
                      return 'Harap masukkan harga jual yang valid';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                // Pilih Gambar
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _gambarProduk == null
                        ? IconButton(
                            icon: Icon(Icons.image),
                            onPressed: _pickImage,
                          )
                        : Image.file(
                            _gambarProduk!,
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                          ),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _simpanData(
                            widget.produk.id,
                            _namaProdukController.text,
                            _kodeProdukController.text,
                            int.parse(_jumlahProdukController.text),
                            _hargaModalController.text,
                            _hargaJualController.text,
                            _gambarProduk,
                          );
                        }
                      },
                      child: Text('Simpan'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
