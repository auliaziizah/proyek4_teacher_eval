import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'pertanyaan_tambah.dart';

class DaftarPertanyaan extends StatefulWidget {
  final Map<String, dynamic> komponen;

  const DaftarPertanyaan({
    Key? key,
    required this.komponen,
  }) : super(key: key);

  @override
  _DaftarPertanyaanState createState() => _DaftarPertanyaanState();
}

class _DaftarPertanyaanState extends State<DaftarPertanyaan> {
  late Future<List<Map<String, dynamic>>> _pertanyaanFuture;

  @override
  void initState() {
    super.initState();
    _pertanyaanFuture = _fetchData();
  }

  Future<List<Map<String, dynamic>>> _fetchData() async {
    final idKomponen = widget.komponen['id'];
    if (idKomponen == null) {
      throw Exception('ID Komponen tidak ditemukan');
    }

    try {
      final response = await http.get(
        Uri.parse(
          'http://127.0.0.1:8000/api/pertanyaan/$idKomponen',
        ),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body)['data'];
        return List<Map<String, dynamic>>.from(
          data.map((e) => Map<String, dynamic>.from(e)),
        );
      } else {
        throw Exception('Failed to load data: ${response.reasonPhrase}');
      }
    } catch (error) {
      throw Exception('Failed to fetch data: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Daftar Pertanyaan'),
            Text(
              'ID Komponen: ${widget.komponen['id']}',
              style: TextStyle(fontSize: 12),
            ),
          ],
        ),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _pertanyaanFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            return ListView.separated(
              itemCount: snapshot.data!.length,
              separatorBuilder: (context, index) => Divider(),
              itemBuilder: (context, index) {
                Map<String, dynamic> pertanyaan = snapshot.data![index];
                return Card(
                  child: ListTile(
                    title: Text(pertanyaan['pertanyaan']),
                    trailing: Wrap(
                      spacing: 8,
                      children: <Widget>[
                        IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => TambahPertanyaan(
                                  idKomponen: widget.komponen['id'],
                                  pertanyaan: pertanyaan,
                                ),
                              ),
                            );
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () async {
                            final success = await _deletePertanyaan(
                                pertanyaan['id'].toString());
                            if (success) {
                              setState(() {
                                _pertanyaanFuture = _fetchData();
                              });
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          } else {
            return Center(child: Text('Tidak ada data'));
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TambahPertanyaan(
                idKomponen: widget.komponen['id'],
              ),
            ),
          );
        },
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  Future<bool> _deletePertanyaan(String id) async {
    int pertanyaanId = int.tryParse(id) ?? 0;
    String apiUrl = 'http://127.0.0.1:8000/api/pertanyaan/delete/$pertanyaanId';

    try {
      bool confirmDelete = await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Konfirmasi Hapus Data'),
            content: Text('Apakah Anda yakin ingin menghapus pertanyaan ini?'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
                child: Text('Ya'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
                child: Text('Tidak'),
              ),
            ],
          );
        },
      );

      if (confirmDelete) {
        var response = await http.delete(Uri.parse(apiUrl));

        if (response.statusCode == 200) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Pertanyaan berhasil dihapus'),
              duration: Duration(seconds: 2),
            ),
          );
          return true;
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Gagal menghapus pertanyaan'),
              duration: Duration(seconds: 2),
            ),
          );
          return false;
        }
      } else {
        return false;
      }
    } catch (error) {
      print('Error: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Terjadi kesalahan. Silakan coba lagi.'),
          duration: Duration(seconds: 2),
        ),
      );
      return false;
    }
  }
}
