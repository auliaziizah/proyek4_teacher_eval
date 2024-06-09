import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shrine/pertanyaan_list.dart';
import 'komponen_tambah.dart';

class KomponenList extends StatefulWidget {
  const KomponenList({Key? key}) : super(key: key);

  @override
  _KomponenListState createState() => _KomponenListState();
}

class _KomponenListState extends State<KomponenList> {
  late Future<List<Map<String, dynamic>>> _komponenFuture;

  @override
  void initState() {
    super.initState();
    _komponenFuture = _fetchData();
  }

  Future<List<Map<String, dynamic>>> _fetchData() async {
    final response =
        await http.get(Uri.parse('http://127.0.0.1:8000/api/komponen'));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body)['data'];
      return List<Map<String, dynamic>>.from(
          data.map((e) => Map<String, dynamic>.from(e)));
    } else {
      throw Exception('Failed to load data: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Komponen Penilaian'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FutureBuilder<List<Map<String, dynamic>>>(
          future: _komponenFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  Map<String, dynamic> komponen = snapshot.data![index];
                  return Card(
                    child: ListTile(
                      title: Text(komponen['nama_komponen']),
                      trailing: Wrap(
                        spacing: 8,
                        children: <Widget>[
                          IconButton(
                            icon: Icon(Icons.edit),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      TambahKomponen(komponen: komponen),
                                ),
                              );
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () async {
                              final success =
                                  await _deleteKomponen(komponen['id']);
                              if (success) {
                                setState(() {
                                  _komponenFuture = _fetchData();
                                });
                              }
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.arrow_forward),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DaftarPertanyaan(
                                    komponen: komponen,
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            } else {
              return Center(child: Text('No Data'));
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TambahKomponen(),
            ),
          );
        },
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  Future<bool> _deleteKomponen(String id) async {
    String apiUrl = 'http://127.0.0.1:8000/api/komponen/delete/$id';

    try {
      bool confirmDelete = await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Konfirmasi Hapus Data'),
            content: Text(
                'Apakah Anda yakin ingin menghapus data komponen penilaian ini?'),
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
        var response = await http.delete(
          Uri.parse(apiUrl),
          headers: {'Content-Type': 'application/json'},
        );

        if (response.statusCode == 200) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Data komponen penilaian berhasil dihapus'),
              duration: Duration(seconds: 2),
            ),
          );
          return true;
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Gagal menghapus data komponen penilaian'),
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
