import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class TambahKomponen extends StatefulWidget {
  final Map<String, dynamic>? komponen;

  const TambahKomponen({Key? key, this.komponen}) : super(key: key);

  @override
  _TambahKomponenState createState() => _TambahKomponenState();
}

class _TambahKomponenState extends State<TambahKomponen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _namaKomponenController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.komponen == null) {
    } else {
      _namaKomponenController.text = widget.komponen!['nama_komponen'];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.komponen == null
            ? 'Tambah Komponen Penilaian'
            : 'Edit Komponen Penilaian'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _namaKomponenController,
                decoration:
                    InputDecoration(labelText: 'Judul Komponen Penilaian'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Judul harus diisi';
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
                child: Text(widget.komponen == null ? 'Tambah' : 'Update'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _submitForm() async {
    Map<String, dynamic> komponenData = {
      'nama_komponen': _namaKomponenController.text,
    };

    String apiUrl;
    if (widget.komponen == null) {
      apiUrl = 'http://127.0.0.1:8000/api/komponen/create';
    } else {
      apiUrl =
          'http://127.0.0.1:8000/api/komponen/update/${widget.komponen!['id']}';
    }

    try {
      var response = widget.komponen == null
          ? await http.post(
              Uri.parse(apiUrl),
              body: json.encode(komponenData),
              headers: {'Content-Type': 'application/json'},
            )
          : await http.put(
              Uri.parse(apiUrl),
              body: json.encode(komponenData),
              headers: {'Content-Type': 'application/json'},
            );

      if (response.statusCode == 200 || response.statusCode == 201) {
        Navigator.of(context).pushReplacementNamed('/komponen_list');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Gagal menyimpan data komponen'),
            duration: Duration(seconds: 2),
          ),
        );
      }
    } catch (error) {
      print('Error: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Terjadi kesalahan. Silakan coba lagi.'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }
}
