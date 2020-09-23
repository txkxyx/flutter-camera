import 'dart:io';

import 'package:flutter/material.dart';

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
          // final path = join((await getApplicationDocumentsDirectory()).path,'${DateTime.now()}.png');
          // File saveImage = File(path);
          // var savedImage = await saveImage.writeAsBytes(await File(imgPath).readAsBytes());
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //   builder: (context) =>
          //       CameraDisplay(imgPath: path),
          //   fullscreenDialog: true));
        },
      ),

    );
  }
}
