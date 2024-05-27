import 'dart:async';
import 'package:flutter/material.dart';
import 'appbar.dart';
import 'tabel_penilaian.dart';

class KepsekHomePage extends StatefulWidget {
  const KepsekHomePage({Key? key}) : super(key: key);

  @override
  _KepsekHomePageState createState() => _KepsekHomePageState();
}

class _KepsekHomePageState extends State<KepsekHomePage> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 5), (Timer timer) {
      if (_currentPage < 2) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
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
                const SizedBox(height: 8.0),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      height: 200.0,
                      child: PageView(
                        controller: _pageController,
                        onPageChanged: (int page) {
                          setState(() {
                            _currentPage = page;
                          });
                        },
                        children: <Widget>[
                          Container(
                            margin: const EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                              color: Colors.grey.withOpacity(0.3),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Center(
                              child: Image.network(
                                'assets/hemster.jpg',
                                fit: BoxFit.cover,
                                width: double.infinity,
                                height: double.infinity,
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                              color: Colors.grey.withOpacity(0.3),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Center(
                              child: Image.network(
                                'assets/hemster.jpg',
                                fit: BoxFit.cover,
                                width: double.infinity,
                                height: double.infinity,
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                              color: Colors.grey.withOpacity(0.3),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Center(
                              child: Image.network(
                                'assets/hemster.jpg',
                                fit: BoxFit.cover,
                                width: double.infinity,
                                height: double.infinity,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      bottom: 10,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          3,
                          (index) => GestureDetector(
                            onTap: () {
                              _pageController.animateToPage(
                                index,
                                duration: const Duration(milliseconds: 500),
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
                SizedBox(
                  height: MediaQuery.of(context).size.height /
                      2, // Set height to half of screen height
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => TeacherList(),
                              ),
                            );
                          },
                          child: Card(
                            elevation: 4.0,
                            margin: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Image.network(
                                    'assets/hemster.jpg',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                const SizedBox(height: 8.0),
                                const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    "Judul Penilaian 1",
                                    style: TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => TeacherList(),
                              ),
                            );
                          },
                          child: Card(
                            elevation: 4.0,
                            margin: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Image.network(
                                    'assets/hemster.jpg',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                const SizedBox(height: 8.0),
                                const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    "Judul Penilaian 2",
                                    style: TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32.0),
                ElevatedButton(
                  onPressed: () {
                    // Navigasi ke halaman TabelPenilaian saat tombol ditekan
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const TabelPenilaian()),
                    );
                  },
                  child: const Text("Penilaian"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Kelas Teacher dan TeacherList tidak berubah

class Teacher {
  String name;
  String subject;
  String imageUrl;

  Teacher(this.name, this.subject, this.imageUrl);
}

class TeacherList extends StatelessWidget {
  final List<Teacher> teachers = [
    Teacher('Guru A', 'Mata Pelajaran 1', 'assets/hemster.jpg'),
    Teacher('Guru B', 'Mata Pelajaran 2', 'assets/hemster.jpg'),
    Teacher('Guru C', 'Mata Pelajaran 3', 'assets/hemster.jpg'),
    Teacher('Guru D', 'Mata Pelajaran 4', 'assets/hemster.jpg'),
    Teacher('Guru E', 'Mata Pelajaran 5', 'assets/hemster.jpg'),
    Teacher('Guru F', 'Mata Pelajaran 6', 'assets/hemster.jpg'),
    Teacher('Guru G', 'Mata Pelajaran 7', 'assets/hemster.jpg'),
    Teacher('Guru F', 'Mata Pelajaran 6', 'assets/hemster.jpg'),
    Teacher('Guru G', 'Mata Pelajaran 7', 'assets/hemster.jpg'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Judul Penilaian'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Center(
              child: Text(
                '', // Teks di tengah atas halaman
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: teachers.length,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 4.0,
                  margin: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    height: 100.0, // Perkecil ukuran card
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 120.0, // Lebar gambar
                            child: AspectRatio(
                              aspectRatio: 1, // Rasio aspek 1:1
                              child: Image.network(
                                teachers[index].imageUrl,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const SizedBox(
                              width: 8.0), // Spasi antara gambar dan deskripsi
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  teachers[index].name,
                                  style: const TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  teachers[index].subject,
                                  style: const TextStyle(
                                    fontSize: 16.0,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Icon(
                              Icons.arrow_forward), // Icon '>' di bagian kanan
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
