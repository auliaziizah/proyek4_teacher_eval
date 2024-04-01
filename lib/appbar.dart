import 'package:flutter/material.dart';
import 'colors.dart';

class AppBarBottomNavigator extends StatelessWidget {
  const AppBarBottomNavigator({Key? key, required this.body}) : super(key: key);

  final Widget body;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'TeacherEval',
          // style: TextStyle(color: white),
        ),
        backgroundColor: white.withOpacity(0),
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.search,
              // color: white,
              semanticLabel: 'search',
            ),
            onPressed: () {
              print('Search button');
            },
          ),
          IconButton(
            icon: const Icon(
              Icons.account_circle,
              // color: white,
              semanticLabel: 'profile',
            ),
            onPressed: () {
              print('Profile button');
            },
          ),
        ],
      ),
      body: body,
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: biru1,
        selectedItemColor: white,
        unselectedItemColor: white.withOpacity(0.5),
        currentIndex: _currentIndex(context),
        onTap: (index) {
          if (index == 0) {
            Navigator.of(context).pushReplacementNamed('/tambah_guru');
          } else if (index == 1) {
            Navigator.of(context).pushReplacementNamed('/');
          } else if (index == 2) {
            Navigator.of(context).pushReplacementNamed('/profile');
          }
        },
        items: [
          BottomNavigationBarItem(
            icon: Container(
              decoration: BoxDecoration(
                color: _currentIndex(context) == 0
                    ? biru2.withOpacity(0.5)
                    : biru1,
                borderRadius: BorderRadius.circular(10),
              ),
              padding: EdgeInsets.all(20),
              child: Icon(Icons.person_add),
            ),
            label: 'Tambah Guru',
          ),
          BottomNavigationBarItem(
            icon: Container(
              decoration: BoxDecoration(
                color: _currentIndex(context) == 1
                    ? biru2.withOpacity(0.5)
                    : biru1,
                borderRadius: BorderRadius.circular(10),
              ),
              padding: EdgeInsets.all(20),
              child: Icon(Icons.home),
            ),
            label: 'Beranda',
          ),
          BottomNavigationBarItem(
            icon: Container(
              decoration: BoxDecoration(
                color: _currentIndex(context) == 2
                    ? biru2.withOpacity(0.5)
                    : biru1,
                borderRadius: BorderRadius.circular(10),
              ),
              padding: EdgeInsets.all(20),
              child: Icon(Icons.person),
            ),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  // Fungsi untuk menentukan indeks yang dipilih berdasarkan rute saat ini
  int _currentIndex(BuildContext context) {
    final currentRoute = ModalRoute.of(context)?.settings.name;
    if (currentRoute == '/') {
      return 1; // Jika berada di halaman beranda, sorot indeks ke-1 (Beranda)
    } else if (currentRoute == '/tambah_guru') {
      return 0; // Jika berada di halaman tambah guru, sorot indeks ke-0 (Tambah Guru)
    } else {
      return 2; // Jika berada di halaman lain, sorot indeks ke-2 (Profile)
    }
  }
}
