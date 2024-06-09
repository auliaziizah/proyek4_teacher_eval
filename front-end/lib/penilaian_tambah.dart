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
  final TextEditingController _judulController = TextEditingController();
  final TextEditingController _tglController = TextEditingController();

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
                decoration: InputDecoration(
                  labelText: 'Tanggal Penilaian',
                  hintText: 'Pilih tanggal',
                ),
                readOnly: true,
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2101),
                  );

                  if (pickedDate != null) {
                    String formattedDate =
                        "${pickedDate.toLocal()}".split(' ')[0];
                    setState(() {
                      _tglController.text = formattedDate;
                    });
                  }
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Tanggal Penilaian harus diisi';
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
    Map<String, String> penilaianData = {
      'judul_penilaian': _judulController.text,
      'tgl_penilaian': _tglController.text,
    };

    String apiUrl = 'http://127.0.0.1:8000/api/penilaian/create';

    try {
      var response = await http.post(
        Uri.parse(apiUrl),
        body: json.encode(penilaianData),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        Navigator.pushReplacementNamed(context, '/kepsek_home');
      } else {
        var responseData = json.decode(response.body);
        String errorMessage = responseData['message'] ?? 'Unknown error';
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Gagal menambahkan data penilaian: $errorMessage'),
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

  @override
  void dispose() {
    _judulController.dispose();
    _tglController.dispose();
    super.dispose();
  }
}
