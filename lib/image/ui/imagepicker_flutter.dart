import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CameraPage extends StatefulWidget {
  const CameraPage({Key? key}) : super(key: key);

  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  final picker = ImagePicker();
  late Future<PickedFile?> pickedFile = Future.value(null);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Camera"),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextButton.icon(
                    onPressed: () async {
                      pickedFile = picker.getImage(source: ImageSource.camera).whenComplete(() => {setState(() {})});
                    },
                    icon: const Icon(Icons.camera_alt_outlined),
                    label: const Text("Camera")),
                TextButton.icon(
                    onPressed: () async {
                      pickedFile = picker
                          .getImage(
                        source: ImageSource.gallery,
                      )
                          .whenComplete(() => {setState(() {})});
                    },
                    icon: const Icon(Icons.photo_camera_back),
                    label: const Text("Gallery")),
              ],
            ),
            const SizedBox(height: 20.0),
            FutureBuilder<PickedFile?>(
              future: pickedFile,
              builder: (context, snap) {
                if (snap.hasData) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      child: Image.file(
                        File(snap.data!.path),
                        fit: BoxFit.contain,
                      ),
                      color: Colors.blue,
                    ),
                  );
                }
                return Container(
                  height: 200.0,
                  color: Colors.lightBlue,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}