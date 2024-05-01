import 'package:flutter/material.dart';
import 'appbar.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBarBottomNavigator(
      body: Scaffold(
        appBar: null, // Menghilangkan appBar
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Menggunakan Center untuk meletakkan judul di tengah
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Text(
                      'Alat Penilaian Kompetensi Guru',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0, // Sesuaikan ukuran font dengan kebutuhan
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text(
                    'Nama Guru',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Masukkan nama guru...',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 16.0), // Adjust the spacing as needed
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text(
                    'NIP',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Masukkan NIP guru...',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 16.0), // Adjust the spacing as needed
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text(
                    'Pangkat/Gol. Ruang',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Masukkan pangkat/golongan ruang...',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 16.0), // Adjust the spacing as needed
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text(
                    'Jabatan',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Masukkan jabatan...',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 16.0), // Adjust the spacing as needed
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text(
                    'Unit Kerja',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Masukkan unit kerja...',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 16.0), // Adjust the spacing as needed
                ElevatedButton(
                  onPressed: () {
                    // Navigator untuk berpindah ke halaman lain
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HalamanLain()),
                    );
                  },
                  child: Text('Next ->'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class HalamanLain extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Halaman Lain')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Text(
                  'Hari/Tanggal Penilaian',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'Masukkan hari/tanggal penilaian...',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16.0), // Adjust the spacing as needed
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Text(
                  'Nama Penilai',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'Masukkan nama penilai...',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16.0), // Adjust the spacing as needed
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Text(
                  'NIP/Pangkat/Gol. Ruang',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'Masukkan NIP/pangkat/golongan ruang...',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16.0), // Adjust the spacing as needed
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Text(
                  'Jabatan',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'Masukkan jabatan...',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16.0), // Adjust the spacing as needed
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Text(
                  'Unit Kerja',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'Masukkan unit kerja...',
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
