import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'penilaian_list_guru.dart';

class Penilaian {
  final int id;
  final String judulPenilaian;
  final DateTime tglPenilaian;

  Penilaian({
    required this.id,
    required this.judulPenilaian,
    required this.tglPenilaian,
  });

  factory Penilaian.fromJson(Map<String, dynamic> json) {
    return Penilaian(
      id: json['id'],
      judulPenilaian: json['judul_penilaian'],
      tglPenilaian: DateTime.parse(json['tgl_penilaian']),
    );
  }
}

class PenilaianService {
  static Future<List<Penilaian>> getPenilaian() async {
    final response =
        await http.get(Uri.parse('http://127.0.0.1:8000/api/penilaian'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body)['data'];
      return data.map((e) => Penilaian.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load penilaian');
    }
  }
}

class KepsekHomePage extends StatefulWidget {
  const KepsekHomePage({Key? key}) : super(key: key);

  @override
  _KepsekHomePageState createState() => _KepsekHomePageState();
}

class _KepsekHomePageState extends State<KepsekHomePage> {
  late Future<List<Penilaian>> _penilaianFuture;

  @override
  void initState() {
    super.initState();
    _penilaianFuture = PenilaianService.getPenilaian();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kepsek Home Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8.0),
            Text("Daftar Penilaian"),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/komponen_list');
              },
              child: Text('Kelola Komponen Penilaian'),
            ),
            Expanded(
              child: FutureBuilder<List<Penilaian>>(
                future: _penilaianFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (snapshot.hasData) {
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        final penilaian = snapshot.data![index];
                        return Card(
                          margin: const EdgeInsets.symmetric(vertical: 8.0),
                          child: ListTile(
                            title: Text(penilaian.judulPenilaian),
                            subtitle: Text(DateFormat('dd-MM-yyyy')
                                .format(penilaian.tglPenilaian)),
                            onTap: () {
                              print(
                                  "ID Penilaian yang dikirim: ${penilaian.id}");
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      DaftarGuru(idPenilaian: penilaian.id),
                                ),
                              );
                            },
                          ),
                        );
                      },
                    );
                  } else {
                    return Center(child: Text('Tidak ada data penilaian'));
                  }
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushReplacementNamed('/tambah_penilaian');
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
