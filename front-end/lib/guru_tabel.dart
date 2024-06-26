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
    try {
      final response =
          await http.get(Uri.parse('http://127.0.0.1:8000/api/guru'));

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body)['data'];
        return List<Map<String, dynamic>>.from(
            data.map((e) => Map<String, dynamic>.from(e)));
      } else {
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('Failed to load data: $error');
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
                } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                  return _buildCardList(snapshot.data!);
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

  Widget _buildCardList(List<Map<String, dynamic>> data) {
    // Filter out data with NIP "1234567"
    data = data.where((item) => item['nip'] != '1234567').toList();

    return ListView.builder(
      padding: EdgeInsets.all(10.0),
      itemCount: data.length,
      itemBuilder: (context, index) {
        Map<String, dynamic> item = data[index];
        return Card(
          margin: EdgeInsets.symmetric(vertical: 10.0),
          child: ListTile(
            contentPadding: EdgeInsets.all(10.0),
            leading: Image.asset('assets/profile.png', width: 50, height: 50),
            title: Text(item['nama'] ?? ''),
            subtitle: Text('NIP: ${item['nip'] ?? ''}'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => DetailGuru(
                                id: item['id'].toString(),
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
                                guru: data[index],
                              )),
                    );
                  },
                  icon: Icon(Icons.edit),
                ),
                IconButton(
                  onPressed: () async {
                    await _deleteGuru(item['id'].toString());
                    setState(() {
                      // Refresh data after deletion
                      _guruFuture = getGuru();
                    });
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

  Future<void> _deleteGuru(String id) async {
    try {
      // Show confirmation dialog
      bool confirmDelete = await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Konfirmasi Hapus Data'),
            content: Text('Apakah Anda yakin ingin menghapus data guru ini?'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(true); // Confirm delete
                },
                child: Text('Ya'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(false); // Cancel delete
                },
                child: Text('Tidak'),
              ),
            ],
          );
        },
      );

      if (confirmDelete) {
        // Send DELETE request to server
        final apiUrl = 'http://127.0.0.1:8000/api/guru/delete/$id';
        final response = await http.delete(
          Uri.parse(apiUrl),
          headers: {'Content-Type': 'application/json'},
        );

        if (response.statusCode == 200) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Data guru berhasil dihapus'),
              duration: Duration(seconds: 2),
            ),
          );
        } else {
          throw Exception('Failed to delete guru data');
        }
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
