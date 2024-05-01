import 'package:flutter/material.dart';
import 'home.dart';
import 'login.dart';
import 'profile.dart';
import 'tabel_guru.dart';
import 'tambah_guru.dart';

class ShrineApp extends StatelessWidget {
  const ShrineApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TeacherEval',
      initialRoute: '/login',
      routes: {
        '/login': (BuildContext context) => const LoginPage(),
        '/': (BuildContext context) => const HomePage(),
        '/tabel_guru': (BuildContext context) => const TabelGuru(),
        '/profile': (BuildContext context) => const Profile(),
        '/tambah_guru': (BuildContext context) => const TambahGuru(),
      },
    );
  }
}
