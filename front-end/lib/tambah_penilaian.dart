import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class TambahPenilaian extends StatefulWidget {
  const TambahPenilaian({Key? key}) : super(key: key);

  @override
  _TambahPenilaianState createState() => _TambahPenilaianState();
}

class _TambahPenilaianState extends State<TambahPenilaian> {
  final _formKey = GlobalKey<FormState>();

  // Controller untuk bidang isian
  final TextEditingController _judulController = TextEditingController();
  final TextEditingController _tglController = TextEditingController();
  final TextEditingController _imageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tambah Data Penilaian'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _judulController,
                decoration: InputDecoration(labelText: 'Judul Penilaian'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Judul Penilaian harus diisi';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _tglController,
                decoration: InputDecoration(labelText: 'Tanggal Penilaian'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Tanggal Penilaian harus diisi';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _imageController,
                decoration: InputDecoration(labelText: 'Image (URL)'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'URL Image harus diisi';
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
                    // Misalnya, simpan data penilaian
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
    // Data penilaian yang akan dikirim ke server
    Map<String, String> penilaianData = {
      'judul_penilaian': _judulController.text,
      'tgl_penilaian': _tglController.text,
      'image': _imageController.text,
    };

    // URL endpoint API untuk menambahkan data penilaian
    String apiUrl = 'http://127.0.0.1:8000/api/penilaian/create';

    try {
      // Kirim permintaan POST ke server
      var response = await http.post(
        Uri.parse(apiUrl),
        body: json.encode(penilaianData),
        headers: {'Content-Type': 'application/json'},
      );

      // Cek status kode respon
      if (response.statusCode == 201) {
        // Data berhasil ditambahkan, tampilkan pesan sukses
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Sukses'),
              content: Text('Data penilaian berhasil ditambahkan!'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    // Kembali ke halaman sebelumnya
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      } else {
        // Terjadi kesalahan saat menambahkan data, tampilkan pesan error
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Gagal menambahkan data penilaian: ${response.body}'),
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
    _judulController.dispose();
    _tglController.dispose();
    _imageController.dispose();
    super.dispose();
  }
}
