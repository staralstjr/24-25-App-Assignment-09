import 'package:flutter/material.dart';
import 'API.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:go_router/go_router.dart';

final _formKey = GlobalKey<FormState>();
final TextEditingController usernameController = TextEditingController();
final TextEditingController passwordController = TextEditingController();
final FlutterSecureStorage secureStorage = FlutterSecureStorage();

class LoginPage extends StatelessWidget {
  final API api = API();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple[50],
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.lock, size: 100, color: Colors.purple),
                SizedBox(height: 20),
                TextFormField(
                  controller: usernameController,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.person),
                    labelText: 'Username',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your username';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.lock),
                    labelText: 'Password',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    await _login(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple,
                  ),
                  child: Text('Login'),
                ),
                TextButton(
                  onPressed: () {
                    context.go('/signUp');
                  },
                  child: Text(
                    "Don't have an account? Sign up",
                    style: TextStyle(color: Colors.purple),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _login(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      final username = usernameController.text;
      final password = passwordController.text;

      final accessToken = await api.login(username, password);
      if (accessToken != null) {
        await secureStorage.write(key: 'access_token', value: accessToken);

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Login Successful')),
        );
        context.go('/home');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('Login Failed. Please check your credentials.')),
        );
      }
    }
  }
}
