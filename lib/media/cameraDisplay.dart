import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path/path.dart';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

class CameraDisplay extends StatelessWidget {
  final String imgPath;

  const CameraDisplay({Key key, this.imgPath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Picture'),
      ),
      body: Column(
        children: [Expanded(child: Image.file(File(imgPath)))],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.save_alt),
        onPressed: () async {
          final result = await ImageGallerySaver.saveImage(await File(imgPath).readAsBytes());
          print(result);
        },
      ),

    );
  }
}
