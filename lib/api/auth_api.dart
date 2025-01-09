import 'dart:convert';
import 'package:http/http.dart' as http;

// Ganti dengan URL API Anda
const String baseUrl = "http://10.0.2.2:3000/api/auth";


class AuthAPI {
  // Fungsi untuk login menggunakan API
  static Future<Map<String, dynamic>> signIn(String username, String password, String role) async {
    final String url = "$baseUrl/login";

    print("Payload yang dikirim: ${jsonEncode({
      'username': username,
      'password': password,
      'role': role
    })}");


    print("Mengirim permintaan ke API login...");
    print("URL: $url");
    print("Payload: {username: $username, password: ${'*' * password.length}, role: pengguna}");

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'username': username,
          'password': password,
          'role': role
        }),
      );

      print("Respons status code: ${response.statusCode}");
      print("Respons body: ${response.body}");

      if (response.statusCode == 200) {
        return jsonDecode(response.body); // Kembalikan data user dari API
      } else {
        throw Exception('Login failed: ${response.body}');
      }
    } catch (e) {
      print("Terjadi kesalahan saat mengakses API login: $e");
      throw Exception('Terjadi kesalahan saat login: $e');
    }
  }


  static Future<Map<String, dynamic>> registerPengguna({
    required String name,
    required String username,
    required String email,
    required String password,
    required String phone,
    required String shopName,
    required String address,
  }) async {
    final url = Uri.parse("$baseUrl/register-pengguna");
    try {
      final response = await http.post(
        url,
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode({
          "nama": name,
          "username": username,
          "email": email,
          "password": password,
          "nomor_telepon": phone,
          "nama_toko": shopName,
          "alamat_toko": address,
        }),
      );

      if (response.statusCode == 201) {
        return {
          "status": "success",
          "message": "User registered successfully",
          "data": jsonDecode(response.body),
        };
      } else {
        return {
          "status": "fail",
          "message": jsonDecode(response.body)["message"] ?? "Registration failed",
        };
      }
    } catch (e) {
      return {
        "status": "error",
        "message": "An error occurred: ${e.toString()}",
      };
    }
  }
}
