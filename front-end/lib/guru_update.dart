import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UpdateGuru extends StatefulWidget {
  final Map guru;
  UpdateGuru({required this.guru});

  @override
  _UpdateGuruState createState() => _UpdateGuruState();
}

class _UpdateGuruState extends State<UpdateGuru> {
  final _formKey = GlobalKey<FormState>();

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
        title: Text('Update Data Guru'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _nipController..text = widget.guru['nip'],
                decoration: InputDecoration(labelText: 'NIP'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'NIP harus diisi';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _namaController..text = widget.guru['nama'],
                decoration: InputDecoration(labelText: 'Nama'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Nama harus diisi';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _golonganController..text = widget.guru['golongan'],
                decoration: InputDecoration(labelText: 'Golongan'),
              ),
              TextFormField(
                controller: _pangkatController..text = widget.guru['pangkat'],
                decoration: InputDecoration(labelText: 'Pangkat'),
              ),
              TextFormField(
                controller: _emailController..text = widget.guru['email'],
                decoration: InputDecoration(labelText: 'Email'),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Email harus diisi';
                  }
                  if (!value.contains('@')) {
                    return 'Email tidak valid';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _passwordController..text = widget.guru['password'],
                decoration: InputDecoration(labelText: 'Password'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Password harus diisi';
                  }
                  if (value.length < 6) {
                    return 'Password harus memiliki minimal 6 karakter';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
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

    // URL endpoint API untuk mengupdate data guru
    String apiUrl =
        'http://127.0.0.1:8000/api/guru/update/${widget.guru['id']}';

    try {
      // Kirim permintaan PUT ke server
      var response = await http.put(
        Uri.parse(apiUrl),
        body: json.encode(guruData),
        headers: {'Content-Type': 'application/json'},
      );

      // Cek status kode respon
      if (response.statusCode == 200) {
        Navigator.of(context).pushReplacementNamed('/tabel_guru');
      } else {
        // Terjadi kesalahan saat mengupdate data, tampilkan pesan error
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Gagal mengupdate data guru'),
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
