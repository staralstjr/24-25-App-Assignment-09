import 'dart:convert';
import 'package:http/http.dart' as http;

class API {
  Future<bool> login(String username, String password) async {
    try {
      final url =
          Uri.parse('https://api.labyrinth30-tech.link/auth/login'); // 로그인 URL
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'username': username, 'password': password}),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseBody = jsonDecode(response.body);
        print('Login successful: ${responseBody}');
        return true;
      } else {
        print('Login failed with status: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      print('Error: $e');
      return false;
    }
  }
}
