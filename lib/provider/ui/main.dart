import 'dart:io';

import 'package:camera_app/provider/model/file_model.dart';
import 'package:camera_app/provider/ui/camera.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CameraMainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (context) => FileModel())],
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Camera Main'),
        ),
        body: Container(
            margin: const EdgeInsets.all(30), child: ImageListWidget()),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CameraPage(),
                ));
          },
        ),
      ),
    );
  }
}

class ImageListWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var fileList = Provider.of<FileModel>(context, listen: true).files;
    return Column(
        children: fileList.map((file) => Image.file(File(file))).toList());
  }
}
