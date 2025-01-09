import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:aplikasir/models/riwayat_pengguna_model.dart';

class RiwayatPenggunaApi {
  final String apiUrl = "http://10.0.2.2:3000"; // Ganti dengan URL backend Anda

  // Mendapatkan semua riwayat pengguna
  Future<List<RiwayatPenggunaModel>> fetchRiwayatPengguna() async {
    try {
      final response =
          await http.get(Uri.parse('$apiUrl/api/riwayat_pengguna/'));
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((json) => RiwayatPenggunaModel.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load riwayat pengguna');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  // Menambahkan riwayat pengguna baru
  Future<bool> tambahRiwayatPengguna(
      RiwayatPenggunaModel riwayatPengguna) async {
    try {
      final response = await http.post(
        Uri.parse('$apiUrl/api/riwayat_pengguna'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(riwayatPengguna.toJson()),
      );
      return response.statusCode == 201;
    } catch (e) {
      print('Error: $e');
      return false;
    }
  }

  // Mengupdate riwayat pengguna
  Future<bool> updateRiwayatPengguna(
      int id, RiwayatPenggunaModel riwayatPengguna) async {
    try {
      final response = await http.put(
        Uri.parse('$apiUrl/api/riwayat_pengguna/$id'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(riwayatPengguna.toJson()),
      );
      return response.statusCode == 200;
    } catch (e) {
      print('Error: $e');
      return false;
    }
  }

  // Menghapus riwayat pengguna
  Future<bool> deleteRiwayatPengguna(int id) async {
    try {
      final response =
          await http.delete(Uri.parse('$apiUrl/api/riwayat_pengguna/$id'));
      return response.statusCode == 200;
    } catch (e) {
      print('Error: $e');
      return false;
    }
  }
}
