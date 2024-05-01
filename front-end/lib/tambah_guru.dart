import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class TambahGuru extends StatefulWidget {
  const TambahGuru({Key? key}) : super(key: key);

  @override
  _TambahGuruState createState() => _TambahGuruState();
}

class _TambahGuruState extends State<TambahGuru> {
  final _formKey = GlobalKey<FormState>();

  // Controller untuk bidang isian
  final TextEditingController _nipController = TextEditingController();
  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _golonganController = TextEditingController();
  final TextEditingController _pangkatController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tambah Data Guru'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _nipController,
                decoration: InputDecoration(labelText: 'NIP'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'NIP harus diisi';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _namaController,
                decoration: InputDecoration(labelText: 'Nama'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Nama harus diisi';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _golonganController,
                decoration: InputDecoration(labelText: 'Golongan'),
              ),
              TextFormField(
                controller: _pangkatController,
                decoration: InputDecoration(labelText: 'Pangkat'),
              ),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(labelText: 'Email'),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Email harus diisi';
                  }
                  // Validasi format email
                  if (!value.contains('@')) {
                    return 'Email tidak valid';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(labelText: 'Password'),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Password harus diisi';
                  }
                  // Validasi panjang password
                  if (value.length < 6) {
                    return 'Password harus memiliki minimal 6 karakter';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Validasi form sebelum disubmit
                  if (_formKey.currentState!.validate()) {
                    // Lakukan sesuatu ketika form valid
                    // Misalnya, simpan data guru
                    _submitForm();
                  }
                },
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _submitForm() async {
    // Data guru yang akan dikirim ke server
    Map<String, String> guruData = {
      'nip': _nipController.text,
      'nama': _namaController.text,
      'golongan': _golonganController.text,
      'pangkat': _pangkatController.text,
      'email': _emailController.text,
      'password': _passwordController.text,
    };

    // URL endpoint API untuk menambahkan data guru
    String apiUrl = 'http://127.0.0.1:8000/api/guru/create';

    try {
      // Kirim permintaan POST ke server
      var response = await http.post(
        Uri.parse(apiUrl),
        body: json.encode(guruData),
        headers: {'Content-Type': 'application/json'},
      );

      // Cek status kode respon
      if (response.statusCode == 200) {
        Navigator.of(context).pushReplacementNamed('/tabel_guru');
      } else {
        // Terjadi kesalahan saat menambahkan data, tampilkan pesan error
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Gagal menambahkan data guru'),
            duration: Duration(seconds: 2),
          ),
        );
      }
    } catch (error) {
      // Tangani kesalahan jika terjadi
      print('Error: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Terjadi kesalahan. Silakan coba lagi.'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  void dispose() {
    // Pastikan untuk membebaskan controller saat widget dihapus dari pohon widget
    _nipController.dispose();
    _namaController.dispose();
    _golonganController.dispose();
    _pangkatController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
