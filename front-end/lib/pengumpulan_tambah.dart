import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:http/http.dart' as http;
import 'pengumpulan_tabel.dart';
import 'dart:typed_data';
import 'package:flutter/foundation.dart' show kIsWeb;

class TambahPengumpulan extends StatefulWidget {
  @override
  _TambahPengumpulanState createState() => _TambahPengumpulanState();
}

class _TambahPengumpulanState extends State<TambahPengumpulan> {
  List<String?> fileNames = [null];
  List<PlatformFile?> selectedFiles = [null];
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  Future<void> pickFile(int index) async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles();
      if (result != null) {
        setState(() {
          fileNames[index] = result.files.single.name;
          selectedFiles[index] = result.files.single;
        });
      }
    } catch (e) {
      print('Error picking file: $e');
    }
  }

  Future<void> uploadFiles() async {
    if (selectedFiles[0] != null) {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('http://127.0.0.1:8000/api/pengumpulan/create'),
      );

      request.fields['id_guru'] = '1'; // Ganti dengan nilai id_guru yang sesuai

      if (kIsWeb) {
        Uint8List? fileBytes = selectedFiles[0]!.bytes;
        if (fileBytes != null) {
          request.files.add(http.MultipartFile.fromBytes(
            'file',
            fileBytes,
            filename: selectedFiles[0]!.name,
          ));
        } else {
          _showSnackBar('Error getting file bytes.');
          return;
        }
      } else {
        request.files.add(
          await http.MultipartFile.fromPath(
            'file',
            selectedFiles[0]!.path!,
            filename: selectedFiles[0]!.name,
          ),
        );
      }

      var res = await request.send();
      if (res.statusCode == 200) {
        _showSnackBar('File ${fileNames[0]} uploaded successfully.');
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => TabelPengumpulan()),
        );
      } else {
        _showSnackBar('File ${fileNames[0]} upload failed.');
        print('Response Status: ${res.statusCode}');
        print('Response Body: ${await res.stream.bytesToString()}');
      }
    } else {
      _showSnackBar('No file selected.');
    }
  }

  void _showSnackBar(String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(title: Text('Pengumpulan File')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildFilePicker(0, 'File'),
            Spacer(),
            Center(
              child: ElevatedButton(
                onPressed: uploadFiles,
                child: Text('Selesai'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildFilePicker(int index, String label) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        SizedBox(height: 8),
        GestureDetector(
          onTap: () => pickFile(index),
          child: DottedBorder(
            color: Colors.blue,
            strokeWidth: 2,
            dashPattern: [6, 3],
            borderType: BorderType.RRect,
            radius: Radius.circular(12),
            child: Container(
              height: 100,
              width: double.infinity,
              alignment: Alignment.center,
              child: fileNames[index] == null
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Drop files or click to upload',
                          style: TextStyle(fontSize: 16),
                        ),
                        SizedBox(height: 8),
                        ElevatedButton(
                          onPressed: () => pickFile(index),
                          child: Text('Browse'),
                        ),
                      ],
                    )
                  : Text(
                      fileNames[index]!,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16),
                    ),
            ),
          ),
        ),
      ],
    );
  }
}
