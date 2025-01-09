import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:aplikasir/models/pelanggan_model.dart';

class PelangganApi {
  final String apiUrl = "http://10.0.2.2:3000"; // Ganti dengan URL backend Anda

  // Mendapatkan semua pelanggan
  Future<List<PelangganModel>> fetchPelanggan() async {
    try {
      final response = await http.get(Uri.parse('$apiUrl/api/pelanggan/'));
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((json) => PelangganModel.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load pelanggan');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  // Menambahkan pelanggan baru
  Future<bool> tambahPelanggan(PelangganModel pelanggan) async {
    try {
      final response = await http.post(
        Uri.parse('$apiUrl/api/pelanggan'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(pelanggan.toJson()),
      );
      return response.statusCode == 201;
    } catch (e) {
      print('Error: $e');
      return false;
    }
  }

  // Mengupdate data pelanggan
  Future<bool> updatePelanggan(int id, PelangganModel pelanggan) async {
    try {
      final response = await http.put(
        Uri.parse('$apiUrl/api/pelanggan/$id'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(pelanggan.toJson()),
      );
      return response.statusCode == 200;
    } catch (e) {
      print('Error: $e');
      return false;
    }
  }

  // Menghapus pelanggan
  Future<bool> deletePelanggan(int id) async {
    try {
      final response =
          await http.delete(Uri.parse('$apiUrl/api/pelanggan/$id'));
      return response.statusCode == 200;
    } catch (e) {
      print('Error: $e');
      return false;
    }
  }
}
