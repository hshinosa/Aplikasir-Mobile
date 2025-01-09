import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:aplikasir/models/pengguna_model.dart';

class PenggunaApi {
  static const String baseUrl = 'http://10.0.2.2:3000/api/pengguna';

  // Get user and detail data
  static Future<PenggunaModel> getUser(int userId) async {
  final url = '$baseUrl/$userId';
  print('Requesting: $url');

  try {
    final response = await http.get(Uri.parse(url));
    print('Response Code: ${response.statusCode}');
    print('Response Body: ${response.body}');

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      print('Decoded JSON: $data');
      return PenggunaModel.fromJson(data);
    } else {
      print('Error: ${response.statusCode}, Body: ${response.body}');
      throw Exception('Failed to fetch user data: ${response.statusCode}');
    }
  } catch (e) {
    print('Exception in getUser: $e');
    rethrow;
  }
}

  // Update user and detail data
  static Future<void> updateUser(int userId, PenggunaModel pengguna) async {
  try {
    final response = await http.put(
      Uri.parse('$baseUrl/$userId'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(pengguna.toJson()),
    );

    if (response.statusCode != 200) {
      print('Error: ${response.statusCode}, Body: ${response.body}');
      throw Exception('Failed to update user data: ${response.statusCode}');
    }
  } catch (e) {
    print('Exception in updateUser: $e');
    rethrow;
  }
}
}
