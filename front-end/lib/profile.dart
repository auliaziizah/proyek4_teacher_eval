import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'appbar.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String _nip = '';
  Map<String, dynamic> _guruData = {};

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

    // Panggil method untuk mengambil data guru berdasarkan NIP
    await _fetchGuruData(_nip);
  }

  Future<void> _fetchGuruData(String nip) async {
    try {
      final response =
          await http.get(Uri.parse('http://127.0.0.1:8000/api/guru/read/$nip'));

      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        setState(() {
          _guruData = json.decode(response.body);
        });
      } else {
        throw Exception('Failed to load guru data: ${response.statusCode}');
      }
    } catch (error) {
      print('Error fetching guru data: $error');
    }
  }

  Future<void> _logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    Navigator.of(context).pushReplacementNamed('/login');
  }

  @override
  Widget build(BuildContext context) {
    return AppBarBottomNavigator(
      body: Scaffold(
        body: Center(
          child: _guruData.isNotEmpty
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 60,
                      backgroundImage: AssetImage('assets/profile.png'),
                    ),
                    SizedBox(height: 20),
                    Card(
                      child: ListTile(
                        title: Text('Nama: ${_guruData['data']['nama']}'),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                        ),
                      ),
                    ),
                    Card(
                      child: ListTile(
                        title: Text('NIP: ${_guruData['data']['nip']}'),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                        ),
                      ),
                    ),
                    Card(
                      child: ListTile(
                        title:
                            Text('Golongan: ${_guruData['data']['golongan']}'),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                        ),
                      ),
                    ),
                    Card(
                      child: ListTile(
                        title: Text('Pangkat: ${_guruData['data']['pangkat']}'),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                        ),
                      ),
                    ),
                    Card(
                      child: ListTile(
                        title: Text('Email: ${_guruData['data']['email']}'),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: _logout,
                      child: Text('Logout'),
                    ),
                  ],
                )
              : CircularProgressIndicator(),
        ),
      ),
    );
  }
}
