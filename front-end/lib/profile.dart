import 'package:flutter/material.dart';
import 'appbar.dart';

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Gunakan AppBarBottomNavigator untuk menampilkan AppBar dan BottomNavigationBar
    return AppBarBottomNavigator(
      // Di sini Anda bisa menambahkan konten tambahan jika diperlukan
      body: Scaffold(
        body: Center(
          child: Text(
            'Halo',
            style: TextStyle(fontSize: 24),
          ),
        ),
      ),
    );
  }
}
