import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _login() async {
    final String nip = _usernameController.text;
    final String password = _passwordController.text;

    // Validasi NIP dan password
    if (nip.isEmpty || password.isEmpty) {
      _showErrorDialog('NIP and password are required.');
      return;
    }

    // Validasi bahwa NIP hanya berupa angka
    if (!_isNumeric(nip)) {
      _showErrorDialog('NIP must be numeric.');
      return;
    }

    // Kirim permintaan login ke backend
    final response = await http.post(
      Uri.parse('http://127.0.0.1:8000/api/login'),
      body: {
        'nip': nip,
        'password': password,
      },
    );

    if (response.statusCode == 200) {
      // Login berhasil
      final Map<String, dynamic> responseData = json.decode(response.body);
      final String token = responseData['token'];

      // Mendapatkan peran pengguna dari data respons
      final String role = responseData['role'];

      // Simpan informasi pengguna di SharedPreferences
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('nip', nip);
      await prefs.setString('token', token);
      await prefs.setString('role', role);

      print('Login successful with token: $token');
      print('Navigating to home page...');
      Navigator.pushReplacementNamed(
        context,
        role == 'kepala_sekolah' ? '/kepsek_home' : '/guru_home',
      );
    } else {
      // Login gagal
      final Map<String, dynamic> responseData = json.decode(response.body);
      final String errorMessage = responseData['message'];
      print('Login failed. Error: $errorMessage');
      _showErrorDialog(errorMessage);
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Login Failed'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  bool _isNumeric(String str) {
    return double.tryParse(str) != null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding:
              const EdgeInsets.symmetric(vertical: 200.0, horizontal: 20.0),
          child: ListView(
            children: <Widget>[
              const SizedBox(height: 80.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Column(
                    children: [
                      Image.asset(
                        'assets/logo_sekolah.png',
                        height: 100,
                      ),
                      const SizedBox(height: 10.0),
                      const Text(
                        'Selamat Datang!',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 15.0),
              TextField(
                controller: _usernameController,
                decoration: const InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  labelText: 'NIP',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                ),
              ),
              const SizedBox(height: 15.0),
              TextField(
                controller: _passwordController,
                decoration: const InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  labelText: 'Password',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                ),
                obscureText: true,
              ),
              const SizedBox(height: 15.0),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                ),
                onPressed: _login,
                child: const Text(
                  'Login',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
