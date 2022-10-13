import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:pinguino/models/sqlite.dart';
import 'package:pinguino/routes/home/home.dart';

class Connect extends StatelessWidget {
  static const routeName = '/connect';
  const Connect({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      const Text('Pingüino',
          style: TextStyle(
              fontWeight: FontWeight.bold, color: Colors.indigo, fontSize: 50)),
      const Text('SQLite client',
          style: TextStyle(
              fontWeight: FontWeight.bold, color: Colors.grey, fontSize: 20)),
      const SizedBox(height: 20),
      Image.asset('assets/icon.png'),
      const SizedBox(height: 25),
      SizedBox(
          width: 400,
          height: 40,
          child: ElevatedButton(
              onPressed: () async {
                final path = await selectFile();
                SQLite(
                    route: path,
                    onCreate: (_) async {
                      Navigator.pushNamedAndRemoveUntil(
                          context, Home.routeName, (route) => false);
                    });
              },
              child: const Text('Select Database',
                  style:
                      TextStyle(fontWeight: FontWeight.w600, fontSize: 20)))),
    ])));
  }
}

Future<String> selectFile() async {
  FilePickerResult? result = await FilePicker.platform.pickFiles();
  if (result == null) throw 'File not found';
  return result.files.single.path!;
}
