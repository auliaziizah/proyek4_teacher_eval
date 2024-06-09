import 'package:flutter/material.dart';
import 'komponen_list.dart';
import 'kepsek_home.dart';
import 'guru_home.dart';
import 'login.dart';
import 'profile.dart';
import 'guru_tabel.dart';
import 'guru_tambah.dart';
import 'penilaian_tambah.dart';
import 'penilaian_tabel.dart';
import 'komponen_tambah.dart';
import 'pengumpulan_tabel.dart';
import 'pengumpulan_tambah.dart';

class ShrineApp extends StatelessWidget {
  const ShrineApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TeacherEval',
      initialRoute: '/login',
      routes: {
        '/login': (BuildContext context) => const LoginPage(),
        '/kepsek_home': (BuildContext context) => KepsekHomePage(),
        '/guru_home': (BuildContext context) => const GuruHomePage(),
        '/tabel_guru': (BuildContext context) => const TabelGuru(),
        '/profile': (BuildContext context) => const Profile(),
        '/tambah_guru': (BuildContext context) => const TambahGuru(),
        '/tambah_penilaian': (BuildContext context) => const TambahPenilaian(),
        '/tabel_penilaian': (BuildContext context) => const TabelPenilaian(),
        '/komponen_list': (BuildContext context) => const KomponenList(),
        '/tambah_komponen': (BuildContext context) => const TambahKomponen(),
        '/tambah_pengumpulan': (BuildContext context) => TambahPengumpulan(),
        '/tabel_pengumpulan': (BuildContext context) => TabelPengumpulan(),
      },
    );
  }
}
