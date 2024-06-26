import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'pengumpulan_tambah.dart';

class TabelPengumpulan extends StatefulWidget {
  const TabelPengumpulan({Key? key}) : super(key: key);

  @override
  _TabelPengumpulanState createState() => _TabelPengumpulanState();
}

class _TabelPengumpulanState extends State<TabelPengumpulan> {
  late Future<List<Map<String, dynamic>>> _pengumpulanFuture;

  @override
  void initState() {
    super.initState();
    _pengumpulanFuture = getPengumpulan();
  }

  Future<List<Map<String, dynamic>>> getPengumpulan() async {
    final response =
        await http.get(Uri.parse('http://127.0.0.1:8000/api/pengumpulan'));

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
        title: Text('Tabel Pengumpulan'),
      ),
      body: Align(
        alignment: Alignment.topCenter,
        child: Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: FutureBuilder<List<Map<String, dynamic>>>(
            future: _pengumpulanFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else if (snapshot.hasData) {
                return _buildListView(snapshot.data!);
              } else {
                return Text('No Data');
              }
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final success = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => TambahPengumpulan()),
          );

          if (success != null && success) {
            setState(() {
              _pengumpulanFuture = getPengumpulan();
            });
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _buildListView(List<Map<String, dynamic>> data) {
    return ListView.builder(
      itemCount: data.length,
      itemBuilder: (context, index) {
        Map<String, dynamic> item = data[index];
        return Card(
          margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          child: ListTile(
            title: Text(item['file_name'].toString()),
            subtitle: Text(item['file_path'].toString()),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
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
                    final success = await _deletePengumpulan(item['id'].toString());
                    if (success) {
                      setState(() {
                        // Memperbarui tabel data setelah menghapus
                        _pengumpulanFuture = getPengumpulan();
                      });
                    }
                  },
                  icon: Icon(Icons.delete),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<bool> _deletePengumpulan(String id) async {
    // URL endpoint API untuk menghapus data pengumpulan
    String apiUrl = 'http://127.0.0.1:8000/api/pengumpulan/delete/$id';

    try {
      // Menampilkan dialog konfirmasi
      bool confirmDelete = await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Konfirmasi Hapus Data'),
            content: Text('Apakah Anda yakin ingin menghapus data pengumpulan ini?'),
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
              content: Text('Data pengumpulan berhasil dihapus'),
              duration: Duration(seconds: 2),
            ),
          );
          return true;
        } else {
          // Gagal menghapus data pengumpulan
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Gagal menghapus data pengumpulan'),
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
