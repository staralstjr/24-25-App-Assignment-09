import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;

class SignUpPage extends StatelessWidget {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple[50],
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.lock_open, size: 100, color: Colors.purple),
              SizedBox(height: 20),
              TextField(
                controller: usernameController,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.person),
                  labelText: 'Username',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.lock),
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  await _signUp(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple,
                ),
                child: Text('Sign Up'),
              ),
              TextButton(
                onPressed: () {
                  context.go('/login');
                },
                child: Text(
                  'Already have an account? Log in',
                  style: TextStyle(color: Colors.purple),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _signUp(BuildContext context) async {
    final username = usernameController.text;
    final password = passwordController.text;

    if (username.isEmpty || password.isEmpty) {
      _showMessage(context, 'Please fill out all fields.');
      return;
    }

    final Map<String, dynamic>? response =
        await _createAccount(username, password);
    if (response != null && response.containsKey('id')) {
      final userId = response['id'];
      _showMessage(context, 'Account created successfully! Your ID: $userId');
      context.go('/login');
    } else {
      _showMessage(context, 'Sign-up failed. Try again.');
    }
  }

  Future<Map<String, dynamic>?> _createAccount(
      String username, String password) async {
    try {
      final url = Uri.parse('https://api.labyrinth30-tech.link/auth/register');
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'username': username, 'password': password}),
      );

      if (response.statusCode == 201) {
        return jsonDecode(response.body);
      } else {
        print('Sign-up failed. Status code: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }

  void _showMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }
}
