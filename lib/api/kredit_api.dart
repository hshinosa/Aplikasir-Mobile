import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:aplikasir/models/kredit_model.dart';

class KreditApi {
  final String apiUrl = "http://10.0.2.2:3000";

  static Future<List<KreditModel>> fetchKreditPengguna() async {
    final String apiUrl = "http://10.0.2.2:3000";

    try {
      final response = await http.get(Uri.parse('$apiUrl/api/kredit/'));
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((json) => KreditModel.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load kredit');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  static Future<List<dynamic>> fetchKreditListPengguna(int userId) async {
    final String apiUrl = "http://10.0.2.2:3000";

    try {
      final response = await http.get(Uri.parse('$apiUrl/api/kredit/$userId'));
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((json) => KreditModel.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load kredit');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<bool> tambahKredit(KreditModel kredit) async {
    try {
      final response = await http.post(
        Uri.parse('$apiUrl/kredit'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(kredit.toJson()),
      );
      return response.statusCode == 201;
    } catch (e) {
      print('Error: $e');
      return false;
    }
  }

  Future<bool> updateKredit(int id, KreditModel kredit) async {
    try {
      final response = await http.put(
        Uri.parse('$apiUrl/kredit/$id'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(kredit.toJson()),
      );
      return response.statusCode == 200;
    } catch (e) {
      print('Error: $e');
      return false;
    }
  }

  Future<bool> deleteKredit(int id) async {
    try {
      final response = await http.delete(Uri.parse('$apiUrl/kredit/$id'));
      return response.statusCode == 200;
    } catch (e) {
      print('Error: $e');
      return false;
    }
  }
}
