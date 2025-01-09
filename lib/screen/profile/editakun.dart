import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:aplikasir/models/pengguna_model.dart';
import 'package:aplikasir/api/pengguna_api.dart';

class EditPage extends StatefulWidget {
  final int userId;

  const EditPage({Key? key, required this.userId}) : super(key: key);

  @override
  _EditPageState createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  late TextEditingController _nameController;
  late TextEditingController _usernameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;
  late TextEditingController _storeNameController;
  late TextEditingController _storeAddressController;

  File? _profileImage;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  Future<void> _initializeData() async {
    try {
      final user = await PenggunaApi.getUser(widget.userId);
      setState(() {
        _nameController = TextEditingController(text: user.nama);
        _usernameController = TextEditingController(text: user.username);
        _emailController = TextEditingController(text: user.email);
        _phoneController = TextEditingController(text: user.nomorTelepon);
        _storeNameController = TextEditingController(text: user.namaToko);
        _storeAddressController = TextEditingController(text: user.alamatToko);
        isLoading = false;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to load user data: $e')),
      );
    }
  }

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _profileImage = File(pickedFile.path);
      });
    }
  }

  Future<void> _saveProfile() async {
    final updatedUser = PenggunaModel(
      id: widget.userId,
      nama: _nameController.text,
      username: _usernameController.text,
      email: _emailController.text,
      role: 'pengguna',
      nomorTelepon: _phoneController.text,
      namaToko: _storeNameController.text,
      alamatToko: _storeAddressController.text,
      gambarQris: 'null',
      fotoProfil: _profileImage?.path ?? '',
      statusAkun: 'aktif',
    );

    try {
      // Handle profile image upload if necessary.
      await PenggunaApi.updateUser(widget.userId, updatedUser);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Profile saved successfully!')),
      );
      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to save profile: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profil'),
        actions: [
          TextButton(
            onPressed: isLoading ? null : _saveProfile,
            child: const Text('Simpan'),
          ),
        ],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    _buildProfileImage(),
                    const SizedBox(height: 20),
                    _buildTextField('Nama', _nameController, Icons.person),
                    _buildTextField('Nama Pengguna', _usernameController, Icons.person_outline),
                    _buildTextField('Email', _emailController, Icons.email),
                    _buildTextField('Nomor Telepon', _phoneController, Icons.phone),
                    _buildTextField('Nama Toko', _storeNameController, Icons.store),
                    _buildTextField('Alamat Toko', _storeAddressController, Icons.location_on),
                  ],
                ),
              ),
            ),
    );
  }

  Widget _buildProfileImage() {
    return Center(
      child: Stack(
        children: [
          CircleAvatar(
            radius: 60,
            backgroundImage: _profileImage != null
                ? FileImage(_profileImage!)
                : const AssetImage('assets/avatar_placeholder.png') as ImageProvider,
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: InkWell(
              onTap: _pickImage,
              child: Container(
                padding: const EdgeInsets.all(6),
                decoration: const BoxDecoration(
                  color: Colors.blue,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.camera_alt,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(
    String label,
    TextEditingController controller,
    IconData icon, {
    bool isPassword = false,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: TextField(
        controller: controller,
        obscureText: isPassword,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),
      ),
    );
  }
}
