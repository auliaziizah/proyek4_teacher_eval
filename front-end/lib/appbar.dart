import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'colors.dart';

class AppBarBottomNavigator extends StatelessWidget {
  const AppBarBottomNavigator({Key? key, required this.body}) : super(key: key);

  final Widget body;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future:
          _getUserRole(), // Mendapatkan peran pengguna dari SharedPreferences
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Jika masih loading, tampilkan loading indicator
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          // Jika terjadi error, tampilkan pesan error
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          // Jika berhasil mendapatkan peran pengguna, lanjutkan dengan menampilkan bottom navigation
          final userRole = snapshot.data!;
          return _buildBottomNavigator(context, userRole);
        }
      },
    );
  }

  // Widget untuk menampilkan Bottom Navigation berdasarkan peran pengguna
  Widget _buildBottomNavigator(BuildContext context, String userRole) {
    // Variabel untuk menyimpan judul halaman
    String pageTitle = '';

    final currentRoute = ModalRoute.of(context)?.settings.name;
    if (currentRoute == '/kepsek_home' || currentRoute == '/guru_home') {
      pageTitle = 'Beranda';
    } else if (currentRoute == '/tabel_guru') {
      pageTitle = 'Data Guru';
    } else if (currentRoute == '/profile') {
      pageTitle = 'Profile';
    }

    // Membuat daftar item Bottom Navigation sesuai peran pengguna
    List<BottomNavigationBarItem> bottomNavItems = [];
    if (userRole == 'kepala_sekolah') {
      bottomNavItems = [
        BottomNavigationBarItem(
          icon: Icon(Icons.person_add),
          label: 'Data Guru',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Beranda',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profile',
        ),
      ];
    } else {
      bottomNavItems = [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Beranda',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profile',
        ),
      ];
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          pageTitle, // Menampilkan judul halaman dinamis
          style: TextStyle(color: const Color.fromARGB(255, 0, 0, 0)),
        ),
        backgroundColor: Colors.transparent,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.account_circle,
              color: const Color.fromARGB(255, 0, 0, 0),
              semanticLabel: 'profile',
            ),
            onPressed: () {
              Navigator.of(context).pushReplacementNamed('/profile');
            },
          ),
        ],
      ),
      body: body,
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: biru1,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white.withOpacity(0.5),
        currentIndex: _currentIndex(context, userRole),
        onTap: (index) {
          if (userRole == 'kepala_sekolah') {
            if (index == 0) {
              Navigator.of(context).pushReplacementNamed('/tabel_guru');
            } else if (index == 1) {
              Navigator.of(context).pushReplacementNamed('/kepsek_home');
            } else if (index == 2) {
              Navigator.of(context).pushReplacementNamed('/profile');
            }
          } else if (userRole == 'guru') {
            if (index == 0) {
              Navigator.of(context).pushReplacementNamed('/guru_home');
            } else if (index == 1) {
              Navigator.of(context).pushReplacementNamed('/profile');
            }
          }
        },
        items: bottomNavItems,
      ),
    );
  }

  // Fungsi untuk menentukan indeks yang dipilih berdasarkan rute saat ini
  int _currentIndex(BuildContext context, String userRole) {
    final currentRoute = ModalRoute.of(context)?.settings.name;
    if (currentRoute == '/kepsek_home' || currentRoute == '/guru_home') {
      return userRole == 'kepala_sekolah' ? 1 : 0;
    } else if (currentRoute == '/tabel_guru') {
      return 0;
    } else if (currentRoute == '/profile') {
      return userRole == 'kepala_sekolah' ? 2 : 1;
    }
    return userRole == 'kepala_sekolah'
        ? 1
        : 0; 
  }

  // Fungsi untuk mendapatkan peran pengguna dari SharedPreferences
  Future<String> _getUserRole() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('role') ?? 'guru';
  }
}
