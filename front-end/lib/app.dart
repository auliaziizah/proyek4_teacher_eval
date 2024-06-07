import 'package:flutter/material.dart';
import 'package:shrine/penilaian_komponen.dart';
import 'kepsek_home.dart';
import 'guru_home.dart';
import 'login.dart';
import 'profile.dart';
import 'guru_tabel.dart';
import 'guru_tambah.dart';
import 'tambah_penilaian.dart';
import 'tabel_penilaian.dart';
import 'penilaian_komponen_tambah.dart';

class ShrineApp extends StatelessWidget {
  const ShrineApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TeacherEval',
      initialRoute: '/login',
      routes: {
        '/login': (BuildContext context) => const LoginPage(),
        '/kepsek_home': (BuildContext context) => const KepsekHomePage(),
        '/guru_home': (BuildContext context) => const GuruHomePage(),
        '/tabel_guru': (BuildContext context) => const TabelGuru(),
        '/profile': (BuildContext context) => const Profile(),
        '/tambah_guru': (BuildContext context) => const TambahGuru(),
        '/tambah_penilaian': (BuildContext context) => const TambahPenilaian(),
        '/tabel_penilaian': (BuildContext context) => const TabelPenilaian(),
        '/komponen_penilaian': (BuildContext context) =>
            const KomponenPenilaian(),
        '/tambah_komponen': (BuildContext context) => const TambahKomponen(),
      },
    );
  }
}
