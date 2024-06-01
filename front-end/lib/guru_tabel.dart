import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shrine/guru_detail.dart';
import 'package:shrine/guru_update.dart';

import 'appbar.dart';

class TabelGuru extends StatefulWidget {
  const TabelGuru({Key? key}) : super(key: key);

  @override
  _TabelGuruState createState() => _TabelGuruState();
}

class _TabelGuruState extends State<TabelGuru> {
  late Future<List<Map<String, dynamic>>> _guruFuture;

  @override
  void initState() {
    super.initState();
    _guruFuture = getGuru();
  }

  Future<List<Map<String, dynamic>>> getGuru() async {
    final response =
        await http.get(Uri.parse('http://127.0.0.1:8000/api/guru'));

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
    return AppBarBottomNavigator(
      body: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).pushReplacementNamed('/tambah_guru');
          },
          child: Icon(Icons.add),
        ),
        body: Align(
          alignment: Alignment.topCenter,
          child: Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: FutureBuilder<List<Map<String, dynamic>>>(
              future: _guruFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else if (snapshot.hasData) {
                  return _buildDataTable(snapshot.data!);
                } else {
                  return Text('No Data');
                }
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDataTable(List<Map<String, dynamic>> data) {
    return DataTable(
      headingTextStyle: TextStyle(fontWeight: FontWeight.bold),
      dataRowHeight: 60,
      columns: [
        DataColumn(label: Text('No')),
        DataColumn(label: Text('NIP')),
        DataColumn(label: Text('Nama')),
        DataColumn(label: Text('Aksi')),
      ],
      rows: data.asMap().entries.map((entry) {
        int index = entry.key + 1; // Nomor dimulai dari 1
        Map<String, dynamic> item = entry.value;
        return DataRow(cells: [
          DataCell(Text('$index')), // Nomor
          DataCell(Text(item['nip'].toString())),
          DataCell(Text(item['nama'].toString())),
          DataCell(
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => DetailGuru(
                                guru: data[index - 1],
                              )),
                    );
                  },
                  icon: Icon(Icons.details),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => UpdateGuru(
                                guru: data[index - 1],
                              )),
                    );
                  },
                  icon: Icon(Icons.edit),
                ),
                IconButton(
                  onPressed: () async {
                    final success = await _deleteGuru(item['id'].toString());
                    if (success) {
                      setState(() {
                        // Memperbarui tabel data setelah menghapus
                        _guruFuture = getGuru();
                      });
                    }
                  },
                  icon: Icon(Icons.delete),
                ),
              ],
            ),
          ),
        ]);
      }).toList(),
    );
  }

  Future<bool> _deleteGuru(String id) async {
    // URL endpoint API untuk menghapus data guru
    String apiUrl = 'http://127.0.0.1:8000/api/guru/delete/$id';

    try {
      // Menampilkan dialog konfirmasi
      bool confirmDelete = await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Konfirmasi Hapus Data'),
            content: Text('Apakah Anda yakin ingin menghapus data guru ini?'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(true); // Konfirmasi hapus
                },
                child: Text('Ya'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(false); // Batal hapus
                },
                child: Text('Tidak'),
              ),
            ],
          );
        },
      );

      // Jika pengguna mengonfirmasi untuk menghapus
      if (confirmDelete) {
        // Kirim permintaan DELETE ke server
        var response = await http.delete(
          Uri.parse(apiUrl),
          headers: {'Content-Type': 'application/json'},
        );

        // Cek status kode respon
        if (response.statusCode == 200) {
          // Data berhasil dihapus
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Data guru berhasil dihapus'),
              duration: Duration(seconds: 2),
            ),
          );
          return true;
        } else {
          // Gagal menghapus data guru
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Gagal menghapus data guru'),
              duration: Duration(seconds: 2),
            ),
          );
          return false;
        }
      } else {
        // Jika pengguna membatalkan hapus
        return false;
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
      return false;
    }
  }
}
