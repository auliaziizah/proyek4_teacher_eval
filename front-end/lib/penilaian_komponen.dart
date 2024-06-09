import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'penilaian_pertanyaan_form.dart';

class KomponenPenilaian extends StatefulWidget {
  final int idPenilaian, idGuru;
  const KomponenPenilaian(
      {Key? key, required this.idPenilaian, required this.idGuru})
      : super(key: key);

  @override
  _KomponenPenilaianState createState() => _KomponenPenilaianState();
}

class _KomponenPenilaianState extends State<KomponenPenilaian> {
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
    print(
        "ID Penilaian dan ID Guru yang diterima: ${widget.idPenilaian} dan ${widget.idGuru}");
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
                      onTap: () {
                        print(
                            "ID Penilaian, ID Guru, dan ID Komponen yang dikirim:  ${widget.idPenilaian}, ${widget.idGuru}, dan ${komponen['id']}");
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PertanyaanForm(
                              komponenId: komponen['id'],
                              idPenilaian: widget.idPenilaian,
                              idGuru: widget.idGuru,
                            ),
                          ),
                        );
                      },
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
    );
  }
}
