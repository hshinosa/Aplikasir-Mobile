import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mime/mime.dart';
import 'package:http_parser/http_parser.dart';
import 'package:aplikasir/models/produk_model.dart';

class ProdukApi {
  final String apiurl = "http://10.0.2.2:3000";

  // Fetch all products
  Future<List<ProdukModel>> fetchProduk() async {
    try {
      final url = Uri.parse('$apiurl/api/produk/');
      final response = await http.get(url, headers: {
        'Content-Type': 'application/json',
      });

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        return data.map((json) => ProdukModel.fromJson(json)).toList();
      } else {
        throw Exception('Gagal memuat data produk');
      }
    } catch (e) {
      throw Exception("Terjadi kesalahan: $e");
    }
  }

  // Add a new product
  Future<bool> tambahProduk(
      int idPengguna,
      File gambarProduk,
      String namaProduk,
      String kodeProduk,
      int jumlahProduk,
      String hargaModal,
      String hargaJual) async {
    try {
      final url = Uri.parse('$apiurl/api/produk/');
      final request = http.MultipartRequest('POST', url);

      request.fields['id_pengguna'] = idPengguna.toString();
      request.fields['nama_produk'] = namaProduk;
      request.fields['kode_produk'] = kodeProduk;
      request.fields['jumlah_produk'] = jumlahProduk.toString();
      request.fields['harga_modal'] = hargaModal;
      request.fields['harga_jual'] = hargaJual;

      if (await gambarProduk.exists()) {
        final mimeType = lookupMimeType(gambarProduk.path) ?? 'image/png';
        request.files.add(await http.MultipartFile.fromPath(
            'gambar_produk', gambarProduk.path,
            contentType: MediaType.parse(mimeType)));
      } else {
        return false;
      }

      final response = await request.send();
      return response.statusCode == 200 || response.statusCode == 201;
    } catch (e) {
      print('Error: $e');
      return false;
    }
  }

  // Update a product
  Future<bool> updateProduk(
      int idProduk,
      String namaProduk,
      String kodeProduk,
      int jumlahProduk,
      String hargaModal,
      String hargaJual,
      File? gambarProduk) async {
    try {
      final url = Uri.parse('$apiurl/api/produk/$idProduk');
      final request = http.MultipartRequest('PUT', url);

      request.fields['nama_produk'] = namaProduk;
      request.fields['kode_produk'] = kodeProduk;
      request.fields['jumlah_produk'] = jumlahProduk.toString();
      request.fields['harga_modal'] = hargaModal;
      request.fields['harga_jual'] = hargaJual;

      if (gambarProduk != null && await gambarProduk.exists()) {
        final mimeType = lookupMimeType(gambarProduk.path) ?? 'image/png';
        request.files.add(await http.MultipartFile.fromPath(
          'gambar_produk',
          gambarProduk.path,
          contentType: MediaType.parse(mimeType),
        ));
      }

      final response = await request.send();
      return response.statusCode == 200;
    } catch (e) {
      print('Error: $e');
      return false;
    }
  }

  // Delete a product
  Future<bool> hapusProduk(int idProduk) async {
    try {
      final url = Uri.parse('$apiurl/api/produk/$idProduk');
      final response = await http.delete(url, headers: {
        'Content-Type': 'application/json',
      });

      return response.statusCode == 200;
    } catch (e) {
      print('Error: $e');
      return false;
    }
  }
}
