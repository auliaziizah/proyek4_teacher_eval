import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'tambah_penilaian.dart';

import 'appbar.dart';

class TabelPenilaian extends StatefulWidget {
  const TabelPenilaian({Key? key}) : super(key: key);

  @override
  _TabelPenilaianState createState() => _TabelPenilaianState();
}

class _TabelPenilaianState extends State<TabelPenilaian> {
  late Future<List<Map<String, dynamic>>> _penilaianFuture;             

  @override
  void initState() {
    super.initState();
    _penilaianFuture = getPenilaian();
  }

  Future<List<Map<String, dynamic>>> getPenilaian() async {
    final response =
        await http.get(Uri.parse('http://127.0.0.1:8000/api/penilaian'));

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
        appBar: AppBar(
          title: Text('Tabel Penilaian'),
        ),
        body: Align(
          alignment: Alignment.topCenter,
          child: Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: FutureBuilder<List<Map<String, dynamic>>>(
              future: _penilaianFuture,
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
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => TambahPenilaian(),
              ),
            );
          },
          child: Icon(Icons.add),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      ),
    );
  }

  Widget _buildDataTable(List<Map<String, dynamic>> data) {
    return DataTable(
      headingTextStyle:
          TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),
      dataRowHeight: 60,
      columns: [
        DataColumn(label: Text('No')),
        DataColumn(label: Text('Judul Penilaian')),
        DataColumn(label: Text('Tanggal Penilaian')),
        DataColumn(label: Text('Aksi')),
      ],
      rows: data.asMap().entries.map((entry) {
        int index = entry.key + 1; // Nomor dimulai dari 1
        Map<String, dynamic> item = entry.value;
        return DataRow(cells: [
          DataCell(Text('$index')), // Nomor
          DataCell(Text(item['judul_penilaian'].toString())),
          DataCell(Text(item['tgl_penilaian'].toString())),
          DataCell(
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    // Tambahkan logika untuk tombol Detail
                    print('Tombol Detail ditekan');
                  },
                  icon: Icon(Icons.details),
                ),
                IconButton(
                  onPressed: () {
                    // Tambahkan logika untuk tombol Edit
                    print('Tombol Edit ditekan');
                  },
                  icon: Icon(Icons.edit),
                ),
                IconButton(
                  onPressed: () async {
                    final success =
                        await _deletePenilaian(item['id'].toString());
                    if (success) {
                      setState(() {
                        // Memperbarui tabel data setelah menghapus
                        _penilaianFuture = getPenilaian();
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

  Future<bool> _deletePenilaian(String id) async {
    // URL endpoint API untuk menghapus data penilaian
    String apiUrl = 'http://127.0.0.1:8000/api/penilaian/delete/$id';

    try {
      // Menampilkan dialog konfirmasi
      bool confirmDelete = await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Konfirmasi Hapus Data'),
            content:
                Text('Apakah Anda yakin ingin menghapus data penilaian ini?'),
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
              content: Text('Data penilaian berhasil dihapus'),
              duration: Duration(seconds: 2),
            ),
          );
          return true;
        } else {
          // Gagal menghapus data penilaian
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Gagal menghapus data penilaian'),
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
