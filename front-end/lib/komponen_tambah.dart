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
  String? _selectedRadioValue1;
  int? _selectedRadioValue2;

  @override
  void initState() {
    super.initState();
    if (widget.komponen == null) {
      _selectedRadioValue1 = '';
      _selectedRadioValue2 = 0;
    } else {
      _namaKomponenController.text = widget.komponen!['nama_komponen'];
      _selectedRadioValue1 = widget.komponen!['tipe_jawaban'];
      _selectedRadioValue2 = widget.komponen!['kesimpulan'];
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
              Text('Tipe Jawaban:'),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RadioListTile<String>(
                    title: const Text('Skor 1 - 5'),
                    value: 'skor',
                    groupValue: _selectedRadioValue1,
                    onChanged: (String? value) {
                      setState(() {
                        _selectedRadioValue1 = value;
                      });
                    },
                  ),
                  RadioListTile<String>(
                    title: Text('Nilai'),
                    value: 'nilai',
                    groupValue: _selectedRadioValue1,
                    onChanged: (String? value) {
                      setState(() {
                        _selectedRadioValue1 = value;
                      });
                    },
                  ),
                  RadioListTile<String>(
                    title: Text('Field Isian'),
                    value: 'form',
                    groupValue: _selectedRadioValue1,
                    onChanged: (String? value) {
                      setState(() {
                        _selectedRadioValue1 = value;
                      });
                    },
                  ),
                ],
              ),
              SizedBox(height: 20),
              Text('Apakah Terdapat Kesimpulan Penilaian?'),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RadioListTile<int>(
                    title: Text('Ya'),
                    value: 1,
                    groupValue: _selectedRadioValue2,
                    onChanged: (int? value) {
                      setState(() {
                        _selectedRadioValue2 = value;
                      });
                    },
                  ),
                  RadioListTile<int>(
                    title: Text('Tidak'),
                    value: 2,
                    groupValue: _selectedRadioValue2,
                    onChanged: (int? value) {
                      setState(() {
                        _selectedRadioValue2 = value;
                      });
                    },
                  ),
                ],
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
      'tipe_jawaban': _selectedRadioValue1,
      'kesimpulan': _selectedRadioValue2,
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
