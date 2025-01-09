import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:aplikasir/models/transaksi_model.dart';

class TransaksiApi {
  final String apiUrl = "http://10.0.2.2:3000"; // Ganti dengan URL backend Anda

  // Fungsi untuk menambahkan transaksi
  Future<bool> tambahTransaksi(TransaksiModel transaksi) async {
    try {
      final response = await http.post(
        Uri.parse('$apiUrl/api/transaksi'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(transaksi.toJson()), // Mengirim data transaksi
      );

      if (response.statusCode == 201) {
        // Jika berhasil, status 201 berarti transaksi berhasil dibuat
        return true;
      } else {
        // Jika gagal, status selain 201
        throw Exception('Gagal menambahkan transaksi');
      }
    } catch (e) {
      print('Error: $e');
      return false;
    }
  }

  Future<List<TransaksiModel>> fetchTransaksi() async {
    try {
      final response = await http.get(Uri.parse('$apiUrl/api/transaksi/'));

      // Log the response for debugging purposes
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);

        // Map the JSON data to TransaksiModel instances
        return data.map((json) => TransaksiModel.fromJson(json)).toList();
      } else {
        // Handle non-200 status codes
        throw Exception(
            'Failed to load transaksi: ${response.statusCode} - ${response.reasonPhrase}');
      }
    } catch (e) {
      // Handle and log errors
      print('Error fetching transaksi: $e');
      throw Exception('Error: $e');
    }
  }

  // Fungsi untuk mengupdate transaksi
  Future<bool> updateTransaksi(int id, TransaksiModel transaksi) async {
    try {
      final response = await http.put(
        Uri.parse('$apiUrl/api/transaksi/$id'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(transaksi.toJson()),
      );
      return response.statusCode == 200;
    } catch (e) {
      print('Error: $e');
      return false;
    }
  }

  // Fungsi untuk menghapus transaksi
  Future<bool> deleteTransaksi(int id) async {
    try {
      final response =
          await http.delete(Uri.parse('$apiUrl/api/transaksi/$id'));
      return response.statusCode == 200;
    } catch (e) {
      print('Error: $e');
      return false;
    }
  }
}
