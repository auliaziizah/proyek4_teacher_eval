import 'package:flutter/material.dart';

class DetailGuru extends StatelessWidget {
  final Map guru;
  DetailGuru({required this.guru});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Detail Guru")),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          _buildDetailItem('Nama:', guru['nama']),
          _buildDetailItem('NIP:', guru['nip']),
          _buildDetailItem('Pangkat:', guru['pangkat']),
          _buildDetailItem('Golongan:', guru['golongan']),
          _buildDetailItem('Email:', guru['email']),
          _buildDetailItem('Password:', guru['password']),
        ],
      ),
    );
  }

  Widget _buildDetailItem(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(width: 8.0),
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.start,
            ),
          ),
        ],
      ),
    );
  }
}
