import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DetailGuru extends StatefulWidget {
  final String id;
  DetailGuru({required this.id});

  @override
  _DetailGuruState createState() => _DetailGuruState();
}

class _DetailGuruState extends State<DetailGuru> {
  Map<String, dynamic>? guruData;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      var response = await http
          .get(Uri.parse('http://127.0.0.1:8000/api/guru/${widget.id}'));
      if (response.statusCode == 200 && mounted) {
        setState(() {
          guruData = json.decode(response.body)['data'];
        });
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Detail Guru")),
      body: guruData == null
          ? Center(child: CircularProgressIndicator())
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildDetailItem('NIP', guruData?['nip'] ?? 'N/A'),
                _buildDetailItem('Nama', guruData?['nama'] ?? 'N/A'),
                _buildDetailItem('Golongan', guruData?['golongan'] ?? 'N/A'),
                _buildDetailItem('Pangkat', guruData?['pangkat'] ?? 'N/A'),
                _buildDetailItem('Email', guruData?['email'] ?? 'N/A'),
                _buildDetailItem('Password', guruData?['password'] ?? 'N/A'),
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
              value, // Tidak perlu menggunakan operator null-aware disini karena sudah ada nilai default 'N/A'
              textAlign: TextAlign.start,
            ),
          ),
        ],
      ),
    );
  }
}
