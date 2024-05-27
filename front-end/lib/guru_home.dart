import 'package:flutter/material.dart';
import 'appbar.dart';

class GuruHomePage extends StatelessWidget {
  const GuruHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Gunakan AppBarBottomNavigator untuk menampilkan AppBar dan BottomNavigationBar
    return AppBarBottomNavigator(
      // Di sini Anda bisa menambahkan konten tambahan jika diperlukan
      body: Scaffold(
        body: Center(
          child: Text(
            'Halo Guru',
            style: TextStyle(fontSize: 24),
          ),
        ),
      ),
    );
  }
}
