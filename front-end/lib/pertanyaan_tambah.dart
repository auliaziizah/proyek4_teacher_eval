import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class TambahPertanyaan extends StatefulWidget {
  final int idKomponen;
  final Map<String, dynamic>? pertanyaan;

  const TambahPertanyaan({Key? key, required this.idKomponen, this.pertanyaan})
      : super(key: key);

  @override
  _TambahPertanyaanState createState() => _TambahPertanyaanState();
}

class _TambahPertanyaanState extends State<TambahPertanyaan> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _pertanyaanController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.pertanyaan != null) {
      _pertanyaanController.text = widget.pertanyaan!['pertanyaan'];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.pertanyaan == null
            ? 'Tambah Pertanyaan'
            : 'Edit Pertanyaan'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _pertanyaanController,
                decoration: InputDecoration(labelText: 'Pertanyaan'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Pertanyaan harus diisi';
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
                child: Text(widget.pertanyaan == null ? 'Tambah' : 'Update'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _submitForm() async {
    Map<String, dynamic> pertanyaanData = {
      'id_komponen': widget.idKomponen,
      'pertanyaan': _pertanyaanController.text,
    };

    String apiUrl;
    if (widget.pertanyaan == null) {
      apiUrl = 'http://127.0.0.1:8000/api/pertanyaan/create';
    } else {
      apiUrl =
          'http://127.0.0.1:8000/api/pertanyaan/update/${widget.pertanyaan!['id']}';
    }

    try {
      var response = widget.pertanyaan == null
          ? await http.post(
              Uri.parse(apiUrl),
              body: json.encode(pertanyaanData),
              headers: {'Content-Type': 'application/json'},
            )
          : await http.put(
              Uri.parse(apiUrl),
              body: json.encode(pertanyaanData),
              headers: {'Content-Type': 'application/json'},
            );

      if (response.statusCode == 200 || response.statusCode == 201) {
        Navigator.of(context).pop();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Gagal menyimpan data pertanyaan'),
            duration: Duration(seconds: 2),
          ),
        );
      }
    } catch (error) {
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
    _pertanyaanController.dispose();
    super.dispose();
  }
}
