import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shrine/penilaian_komponen.dart';

class Guru {
  final int id;
  final String nip;
  final String nama;
  final String pangkat;
  final String golongan;
  final String email;

  Guru({
    required this.id,
    required this.nip,
    required this.nama,
    required this.pangkat,
    required this.golongan,
    required this.email,
  });

  factory Guru.fromJson(Map<String, dynamic> json) {
    return Guru(
      id: json['id'],
      nip: json['nip'],
      nama: json['nama'],
      pangkat: json['pangkat'],
      golongan: json['golongan'],
      email: json['email'],
    );
  }
}

class GuruService {
  static Future<List<Guru>> getGuru() async {
    final response =
        await http.get(Uri.parse('http://127.0.0.1:8000/api/guru'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body)['data'];
      // Filter data guru dengan nip != 1234567
      List<Guru> filteredGurus = data
          .map((e) => Guru.fromJson(e))
          .where((guru) => guru.nip != '1234567')
          .toList();
      return filteredGurus;
    } else {
      throw Exception('Failed to load gurus');
    }
  }
}

class DaftarGuru extends StatelessWidget {
  final int idPenilaian;
  const DaftarGuru({Key? key, required this.idPenilaian}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("ID Penilaian yang diterima: $idPenilaian");

    return Scaffold(
      appBar: AppBar(
        title: Text('Daftar Guru'),
      ),
      body: FutureBuilder<List<Guru>>(
        future: GuruService.getGuru(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final guru = snapshot.data![index];
                return Card(
                  margin: const EdgeInsets.all(8.0),
                  child: ListTile(
                    title: Text(guru.nama),
                    subtitle: Text(guru.nip),
                    onTap: () {
                      print(
                          "ID Penilaian dan ID Guru yang dikirim: $idPenilaian dan ${guru.id}");
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => KomponenPenilaian(
                            idPenilaian: idPenilaian,
                            idGuru: guru.id,
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            );
          } else {
            return Center(child: Text('Tidak ada data guru'));
          }
        },
      ),
    );
  }
}
