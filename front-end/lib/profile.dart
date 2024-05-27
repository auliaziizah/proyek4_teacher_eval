import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'appbar.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String _nip = '';

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _nip = prefs.getString('nip') ?? 'Unknown';
    });
  }

  Future<void> _logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear(); // Menghapus semua data pengguna dari SharedPreferences
    // Navigasi kembali ke halaman login (ganti dengan sesuai kebutuhan)
    Navigator.of(context).pushReplacementNamed('/login');
  }

  @override
  Widget build(BuildContext context) {
    // Gunakan AppBarBottomNavigator untuk menampilkan AppBar dan BottomNavigationBar
    return AppBarBottomNavigator(
      // Di sini Anda bisa menambahkan konten tambahan jika diperlukan
      body: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Halo, $_nip',
                style: TextStyle(fontSize: 24),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _logout,
                child: Text('Logout'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
