import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DetailGuru extends StatefulWidget {
  final int id;
  DetailGuru({required this.id});

  @override
  _DetailGuruState createState() => _DetailGuruState();
}

class _DetailGuruState extends State<DetailGuru> {
  late Map<String, dynamic> guruData;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    var response = await http
        .get(Uri.parse('http://127.0.0.1:8000/api/guru/${widget.id}'));
    if (response.statusCode == 200) {
      setState(() {
        guruData = json.decode(response.body);
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Detail Guru")),
      body: guruData == null
          ? Center(child: CircularProgressIndicator())
          : ListView(
              padding: EdgeInsets.all(16.0),
              children: [
                _buildDetailItem('Nama:', guruData['nama']),
                _buildDetailItem('NIP:', guruData['nip']),
                _buildDetailItem('Pangkat:', guruData['pangkat']),
                _buildDetailItem('Golongan:', guruData['golongan']),
                _buildDetailItem('Email:', guruData['email']),
                _buildDetailItem('Password:', guruData['password']),
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
