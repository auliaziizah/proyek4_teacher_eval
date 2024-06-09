import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'appbar.dart';
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
  final PageController _pageController = PageController();
  int _currentPage = 0;

  // Daftar gambar
  List<String> _imageList = [
    'assets/hemster.jpg',
  ];

  @override
  void initState() {
    super.initState();
    _penilaianFuture = PenilaianService.getPenilaian();
  }

  @override
  Widget build(BuildContext context) {
    return AppBarBottomNavigator(
      body: Scaffold(
        appBar: null,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      height: 300.0,
                      child: PageView.builder(
                        controller: _pageController,
                        onPageChanged: (int page) {
                          setState(() {
                            _currentPage = page;
                          });
                        },
                        itemCount: _imageList
                            .length, // Menggunakan panjang daftar gambar
                        itemBuilder: (context, index) {
                          return Container(
                            margin: const EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                              color: Colors.grey.withOpacity(0.3),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Center(
                              child: Image.asset(
                                _imageList[index],
                                fit: BoxFit.cover,
                                width: double.infinity,
                                height: double.infinity,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    Positioned(
                      bottom: 10,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: List.generate(
                          _imageList
                              .length, // Menggunakan panjang daftar gambar
                          (index) => GestureDetector(
                            onTap: () {
                              _pageController.animateToPage(
                                index,
                                duration: const Duration(seconds: 500),
                                curve: Curves.easeInOut,
                              );
                            },
                            child: Container(
                              width: 8.0,
                              height: 8.0,
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 4.0),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: _currentPage == index
                                    ? Colors.blue
                                    : Colors.grey,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8.0),
                Text("Daftar Penilaian"),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/komponen_list');
                      },
                      child: Text('Kelola Komponen Penilaian'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/tambah_penilaian');
                      },
                      child: Text('Tambah Penilaian'),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                FutureBuilder<List<Penilaian>>(
                  future: _penilaianFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else if (snapshot.hasData) {
                      return ListView.builder(
                        shrinkWrap: true,
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
