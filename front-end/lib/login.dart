import 'package:flutter/material.dart';
import 'colors.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 200.0, horizontal: 20.0),
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
                      Text(
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
                  fillColor: white,
                  labelText: 'NIP',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: abu),
                  ),
                ),
              ),
              const SizedBox(height: 15.0),
              TextField(
                controller: _passwordController,
                decoration: const InputDecoration(
                  filled: true,
                  fillColor: white,
                  labelText: 'Password',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: abu),
                  ),
                ),
                obscureText: true,
              ),
              SizedBox(
                height: 15.0,
              ), // Tambahkan spasi antara TextField dan tombol
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: biru4,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  'Login',
                  style: TextStyle(color: white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
