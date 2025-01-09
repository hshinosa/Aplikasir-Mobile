import 'dart:io';
import 'package:aplikasir/models/laporan_model.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mime/mime.dart';
import 'package:http_parser/http_parser.dart';
import '../screen/laporan/laporan.dart';

class LaporanApi {
  static const String baseUrl = "http://10.0.2.2:3000";

  // Fetch all laporan
  static Future<List<LaporanModel>> getLaporan() async {
    final response = await http.get(Uri.parse('$baseUrl/api/laporan'));
    print('Response Status: ${response.statusCode}');
    print('Response Body: ${response.body}');

    if (response.statusCode == 200) {
      List jsonResponse = jsonDecode(response.body);
      return jsonResponse.map((data) => LaporanModel.fromJson(data)).toList();
    } else {
      print('Error: ${response.reasonPhrase}');
      throw Exception('Failed to load laporan');
    }
  }

  static Future<LaporanModel> getLaporanById(int id) async {
    final response = await http.get(Uri.parse('$baseUrl/items/$id'));

    if (response.statusCode == 200) {
      return LaporanModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load laporan');
    }
  }

  // Create laporan
  static Future<LaporanModel> createLaporan(LaporanModel laporan) async {
    final response = await http.post(
      Uri.parse('$baseUrl/items'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(laporan.toJson()),
    );

    if (response.statusCode == 201) {
      return LaporanModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to create laporan');
    }
  }

  // Update laporan
  static Future<LaporanModel> updateLaporan(
      int id, LaporanModel laporan) async {
    final response = await http.put(
      Uri.parse('$baseUrl/items/$id'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(laporan.toJson()),
    );

    if (response.statusCode == 200) {
      return LaporanModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to update laporan');
    }
  }

  // Delete laporan
  static Future<void> deleteLaporan(int id) async {
    final response = await http.delete(Uri.parse('$baseUrl/items/$id'));

    if (response.statusCode != 200) {
      throw Exception('Failed to delete laporan');
    }
  }
}
