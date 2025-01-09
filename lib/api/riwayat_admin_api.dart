import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:aplikasir/models/riwayat_admin_model.dart';

class RiwayatAdminApi {
  final String apiUrl = "http://10.0.2.2:3000"; // Ganti dengan URL backend Anda

  // Mendapatkan semua riwayat admin
  Future<List<RiwayatAdminModel>> fetchRiwayatAdmin() async {
    try {
      final response = await http.get(Uri.parse('$apiUrl/api/riwayat_admin/'));
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((json) => RiwayatAdminModel.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load riwayat admin');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  // Menambahkan riwayat admin baru
  Future<bool> tambahRiwayatAdmin(RiwayatAdminModel riwayatAdmin) async {
    try {
      final response = await http.post(
        Uri.parse('$apiUrl/api/riwayat_admin'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(riwayatAdmin.toJson()),
      );
      return response.statusCode == 201;
    } catch (e) {
      print('Error: $e');
      return false;
    }
  }

  // Mengupdate riwayat admin
  Future<bool> updateRiwayatAdmin(
      int id, RiwayatAdminModel riwayatAdmin) async {
    try {
      final response = await http.put(
        Uri.parse('$apiUrl/api/riwayat_admin/$id'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(riwayatAdmin.toJson()),
      );
      return response.statusCode == 200;
    } catch (e) {
      print('Error: $e');
      return false;
    }
  }

  // Menghapus riwayat admin
  Future<bool> deleteRiwayatAdmin(int id) async {
    try {
      final response =
          await http.delete(Uri.parse('$apiUrl/api/riwayat_admin/$id'));
      return response.statusCode == 200;
    } catch (e) {
      print('Error: $e');
      return false;
    }
  }
}
