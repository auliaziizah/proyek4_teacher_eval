import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class HasilPenilaian extends StatefulWidget {
  final int idPenilaian;
  final int idGuru;
  final int idKomponen;

  const HasilPenilaian({
    Key? key,
    required this.idPenilaian,
    required this.idGuru,
    required this.idKomponen,
  }) : super(key: key);

  @override
  _HasilPenilaianState createState() => _HasilPenilaianState();
}

class _HasilPenilaianState extends State<HasilPenilaian> {
  late Future<List<Map<String, dynamic>>> fetchData;

  @override
  void initState() {
    super.initState();
    fetchData = _fetchData();
  }

  Future<List<Map<String, dynamic>>> _fetchData() async {
    final response = await http.get(Uri.parse(
        'http://127.0.0.1:8000/api/jawaban/${widget.idPenilaian}/${widget.idGuru}/${widget.idKomponen}'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      return List<Map<String, dynamic>>.from(responseData['data']);
    } else {
      throw ('Penilaian Belum Dilakukan');
    }
  }

  Future<String> getPertanyaan(int idPertanyaan) async {
    final response = await http.get(
        Uri.parse('http://127.0.0.1:8000/api/pertanyaan/read/$idPertanyaan'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      if (responseData['data'] != null && responseData['data'].isNotEmpty) {
        return responseData['data']['pertanyaan'];
      } else {
        throw ('Pertanyaan tidak ditemukan');
      }
    } else {
      throw ('Gagal mendapatkan pertanyaan');
    }
  }

  Future<Map<String, dynamic>> getJawabanDanSkor(int idPertanyaan) async {
    final response = await http.get(Uri.parse(
        'http://127.0.0.1:8000/api/jawaban/${widget.idPenilaian}/${widget.idGuru}/${widget.idKomponen}/$idPertanyaan'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      return responseData['data'];
    } else {
      throw ('Gagal mendapatkan jawaban dan skor');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Data Jawaban'),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: fetchData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
              child: Text('Data jawaban tidak ditemukan'),
            );
          } else {
            final List<Map<String, dynamic>> data = snapshot.data!;
            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columns: [
                  DataColumn(label: Text('Pertanyaan')),
                  DataColumn(label: Text('Skor')),
                  DataColumn(label: Text('Ketersediaan')),
                  DataColumn(label: Text('Keterangan')),
                ],
                rows: data.map((item) {
                  final int idPertanyaan = item['id_pertanyaan'];
                  return DataRow(cells: [
                    DataCell(FutureBuilder<String>(
                      future: getPertanyaan(idPertanyaan),
                      builder: (context, pertanyaanSnapshot) {
                        if (pertanyaanSnapshot.connectionState ==
                            ConnectionState.waiting) {
                          return CircularProgressIndicator();
                        } else if (pertanyaanSnapshot.hasError) {
                          return Text('Error');
                        } else {
                          return Text(pertanyaanSnapshot.data ?? 'N/A');
                        }
                      },
                    )),
                    DataCell(FutureBuilder<Map<String, dynamic>>(
                      future: getJawabanDanSkor(idPertanyaan),
                      builder: (context, jawabanSnapshot) {
                        if (jawabanSnapshot.connectionState ==
                            ConnectionState.waiting) {
                          return CircularProgressIndicator();
                        } else if (jawabanSnapshot.hasError) {
                          return Text('Error');
                        } else {
                          final jawabanData = jawabanSnapshot.data;
                          return Text(jawabanData?['skor'].toString() ?? 'N/A');
                        }
                      },
                    )),
                    DataCell(
                      FutureBuilder<Map<String, dynamic>>(
                        future: getJawabanDanSkor(idPertanyaan),
                        builder: (context, jawabanSnapshot) {
                          if (jawabanSnapshot.connectionState ==
                              ConnectionState.waiting) {
                            return CircularProgressIndicator();
                          } else if (jawabanSnapshot.hasError) {
                            return Text('Error');
                          } else {
                            final jawabanData = jawabanSnapshot.data;
                            final ketersediaan = jawabanData?['ketersediaan'];
                            final ketersediaanText = ketersediaan == 1
                                ? 'ada'
                                : (ketersediaan == 0 ? 'tidak ada' : 'N/A');
                            return Text(ketersediaanText);
                          }
                        },
                      ),
                    ),
                    DataCell(FutureBuilder<Map<String, dynamic>>(
                      future: getJawabanDanSkor(idPertanyaan),
                      builder: (context, jawabanSnapshot) {
                        if (jawabanSnapshot.connectionState ==
                            ConnectionState.waiting) {
                          return CircularProgressIndicator();
                        } else if (jawabanSnapshot.hasError) {
                          return Text('Error');
                        } else {
                          final jawabanData = jawabanSnapshot.data;
                          return Text(
                              jawabanData?['keterangan'].toString() ?? 'N/A');
                        }
                      },
                    )),
                  ]);
                }).toList(),
              ),
            );
          }
        },
      ),
    );
  }
}
