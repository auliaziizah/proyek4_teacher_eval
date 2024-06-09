import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:http/http.dart' as http;
import 'pengumpulan_tabel.dart';


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
        Uri.parse('http://127.0.0.1:8000/api/pengumpulan'),
      );
      request.files.add(
        await http.MultipartFile.fromPath(
          'file',
          selectedFiles[0]!.path!,
          filename: selectedFiles[0]!.name,
        ),
      );
      var res = await request.send();
      if (res.statusCode == 200) {
        _showSnackBar('File ${fileNames[0]} uploaded successfully.');
      } else {
        _showSnackBar('File ${fileNames[0]} upload failed.');
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
