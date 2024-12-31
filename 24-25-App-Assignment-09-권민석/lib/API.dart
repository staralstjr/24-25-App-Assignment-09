import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class API {
  Future<String?> login(String username, String password) async {
    try {
      final url = Uri.parse('https://api.labyrinth30-tech.link/auth/login');
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'username': username, 'password': password}),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        final accessToken = data['access_token'] as String?;
        if (accessToken != null) {
          return accessToken;
        } else {
          print('Access token not found in response.');
          return null;
        }
      } else {
        print('Login failed. Status code: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error during login: $e');
      return null;
    }
  }

  Future<String?> refreshAccessToken(String refreshToken) async {
    try {
      final url =
          Uri.parse('https://api.labyrinth30-tech.link/auth/token/refresh');
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'refresh_token': refreshToken}),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        return data['access_token'] as String?;
      } else {
        print('Token refresh failed. Status code: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error during token refresh: $e');
      return null;
    }
  }

  Future<bool> register(String username, String password) async {
    try {
      final url = Uri.parse('https://api.labyrinth30-tech.link/auth/register');
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'username': username, 'password': password}),
      );

      return response.statusCode == 201;
    } catch (e) {
      print('Error during registration: $e');
      return false;
    }
  }
}
