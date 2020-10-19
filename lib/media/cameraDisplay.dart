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
        body: Column(children: [Expanded(child: Image.file(File(imgPath)))]));
  }
}
