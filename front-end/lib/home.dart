import 'dart:async';
import 'package:flutter/material.dart';
import 'appbar.dart';
import 'tambah_penilaian.dart'; // Imoprt file tambah_penilaian.dart
import 'tabel_penilaian.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(Duration(seconds: 5), (Timer timer) {
      if (_currentPage < 2) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      _pageController.animateToPage(
        _currentPage,
        duration: Duration(milliseconds: 500),
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
                SizedBox(height: 8.0),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
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
                            margin: EdgeInsets.all(8.0),
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
                            margin: EdgeInsets.all(8.0),
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
                            margin: EdgeInsets.all(8.0),
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
                                duration: Duration(milliseconds: 500),
                                curve: Curves.easeInOut,
                              );
                            },
                            child: Container(
                              width: 8.0,
                              height: 8.0,
                              margin: EdgeInsets.symmetric(horizontal: 4.0),
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
                            // You can navigate to any other page here.
                          },
                          child: Card(
                            elevation: 4.0,
                            margin: EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Image.network(
                                    'assets/hemster.jpg',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                SizedBox(height: 8.0),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
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
                            // You can navigate to any other page here.
                          },
                          child: Card(
                            elevation: 4.0,
                            margin: EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Image.network(
                                    'assets/hemster.jpg',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                SizedBox(height: 8.0),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
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
                SizedBox(height: 32.0),
                ElevatedButton(
                  onPressed: () {
                    // Navigasi ke halaman TabelPenilaian saat tombol ditekan
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => TabelPenilaian()),
                    );
                  },
                  child: Text("Penilaian"),
                ),
              ],
            ),
          ),
        ),
      ),  
    );
  }
}
