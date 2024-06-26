import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Pertanyaan {
  final int id;
  final int idPenilaian;
  final int idGuru;
  final int idKomponen;
  final String pertanyaan;

  Pertanyaan({
    required this.id,
    required this.idPenilaian,
    required this.idGuru,
    required this.idKomponen,
    required this.pertanyaan,
  });

  factory Pertanyaan.fromJson(Map<String, dynamic> json) {
    return Pertanyaan(
      id: json['id'] as int,
      idPenilaian: json['id_penilaian'] as int,
      idGuru: json['id_guru'] as int,
      idKomponen: json['id_komponen'] as int,
      pertanyaan: json['pertanyaan'] as String,
    );
  }
}

class PertanyaanService {
  static Future<List<Pertanyaan>> getPertanyaan(
      int komponenId, int idPenilaian, int idGuru) async {
    final response = await http
        .get(Uri.parse('http://127.0.0.1:8000/api/pertanyaan/$komponenId'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body)['data'];
      return data
          .map((e) => Pertanyaan.fromJson({
                ...e,
                'id_penilaian': idPenilaian,
                'id_guru': idGuru,
                'id_komponen': komponenId,
              }))
          .toList();
    } else {
      throw Exception('Failed to load pertanyaan');
    }
  }
}

class PertanyaanForm extends StatefulWidget {
  final int komponenId;
  final int idPenilaian;
  final int idGuru;

  PertanyaanForm(
      {required this.komponenId,
      required this.idPenilaian,
      required this.idGuru});

  @override
  _PertanyaanFormState createState() => _PertanyaanFormState();
}

class _PertanyaanFormState extends State<PertanyaanForm> {
  late Future<List<Pertanyaan>> _pertanyaanFuture;
  final Map<int, int> _skorJawabanMap = {};
  final Map<int, int> _ketersediaanJawabanMap = {};
  final Map<int, String> _textJawabanMap = {};

  @override
  void initState() {
    super.initState();
    _pertanyaanFuture = _fetchPertanyaan();
  }

  Future<List<Pertanyaan>> _fetchPertanyaan() async {
    try {
      return await PertanyaanService.getPertanyaan(
          widget.komponenId, widget.idPenilaian, widget.idGuru);
    } catch (e) {
      print('Error fetching pertanyaan: $e');
      return Future.error('Gagal memuat pertanyaan: $e');
    }
  }

  void _setSkorJawaban(int id, int value) {
    setState(() {
      _skorJawabanMap[id] = value;
    });
  }

  void _setKetersediaanJawaban(int id, int value) {
    setState(() {
      _ketersediaanJawabanMap[id] = value;
    });
  }

  void _setTextJawaban(int id, String value) {
    setState(() {
      _textJawabanMap[id] = value;
    });
  }

  Future<void> submitJawaban(
      int idPertanyaan, int skor, int ketersediaan, String keterangan) async {
    try {
      final response = await http.post(
        Uri.parse('http://127.0.0.1:8000/api/jawaban/create'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'id_penilaian': widget.idPenilaian,
          'id_guru': widget.idGuru,
          'id_komponen': widget.komponenId,
          'id_pertanyaan': idPertanyaan,
          'skor': skor,
          'ketersediaan': ketersediaan,
          'keterangan': keterangan,
        }),
      );

      if (response.statusCode == 200) {
        print('Jawaban berhasil dikirim');
      } else {
        print('Gagal mengirim jawaban: ${response.reasonPhrase}');
      }
    } catch (e) {
      print('Gagal mengirim jawaban: $e');
    }
  }

  Future<void> submitAllJawaban() async {
    for (var idPertanyaan in _skorJawabanMap.keys) {
      final int skor = _skorJawabanMap[idPertanyaan] ?? 0;
      final int ketersediaan = _ketersediaanJawabanMap[idPertanyaan] ?? 0;
      final String keterangan = _textJawabanMap[idPertanyaan] ?? '';

      await submitJawaban(idPertanyaan, skor, ketersediaan, keterangan);
    }

    Navigator.pushNamed(context, '/kepsek_home');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Form Pertanyaan'),
      ),
      body: FutureBuilder<List<Pertanyaan>>(
        future: _pertanyaanFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      final pertanyaan = snapshot.data![index];
                      return ListTile(
                        title: Text(pertanyaan.pertanyaan),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                                'Keterangan : 1  :  Sangat Tidak Baik  2 : Tidak Baik  3 : Kurang Baik 4: Baik  5 : Baik Sekali'),
                            Text('Jawaban (1-5):'),
                            Row(
                              children: List.generate(5, (int i) {
                                final value = i + 1;
                                return Expanded(
                                  child: RadioListTile<int>(
                                    title: Text('$value'),
                                    value: value,
                                    groupValue: _skorJawabanMap[pertanyaan.id],
                                    onChanged: (newValue) {
                                      _setSkorJawaban(pertanyaan.id, newValue!);
                                    },
                                  ),
                                );
                              }),
                            ),
                            Text('Ketersediaan (Ada/Tidak):'),
                            Column(
                              children: <Widget>[
                                RadioListTile<int>(
                                  title: Text('Ada'),
                                  value: 1,
                                  groupValue:
                                      _ketersediaanJawabanMap[pertanyaan.id],
                                  onChanged: (value) {
                                    _setKetersediaanJawaban(
                                        pertanyaan.id, value!);
                                  },
                                ),
                                RadioListTile<int>(
                                  title: Text('Tidak'),
                                  value: 0,
                                  groupValue:
                                      _ketersediaanJawabanMap[pertanyaan.id],
                                  onChanged: (value) {
                                    _setKetersediaanJawaban(
                                        pertanyaan.id, value!);
                                  },
                                ),
                              ],
                            ),
                            SizedBox(height: 8),
                            Text('Jawaban Teks:'),
                            TextField(
                              onChanged: (value) {
                                _setTextJawaban(pertanyaan.id, value);
                              },
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Isi jawaban',
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                ElevatedButton(
                  onPressed: submitAllJawaban,
                  child: Text('Submit Semua Jawaban'),
                ),
              ],
            );
          } else {
            return Center(child: Text('Tidak ada data pertanyaan'));
          }
        },
      ),
    );
  }
}
