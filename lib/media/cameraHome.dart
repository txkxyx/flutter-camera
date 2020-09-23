import 'dart:async';

import 'package:camera/camera.dart';
import 'package:camera_app/media/cameraDisplay.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' show join;
import 'package:path_provider/path_provider.dart';

class CameraHome extends StatefulWidget {
  final CameraDescription camera;

  const CameraHome({Key key, @required this.camera}) : super(key: key);

  @override
  State<StatefulWidget> createState() => CameraHomeState();
}

class CameraHomeState extends State<CameraHome> {
  // デバイスのカメラを制御するコントローラ
  CameraController _cameraController;
  // コントローラーに設定されたカメラを初期化する関数
  Future<void> _initializeCameraController;

  @override
  void initState() {
    super.initState();

    // コントローラを初期化
    _cameraController = CameraController(
        // 使用するカメラをコントローラに設定
        widget.camera,
        // 使用する解像度を設定
        // low : 352x288 on iOS, 240p (320x240) on Android
        // medium : 480p (640x480 on iOS, 720x480 on Android)
        // high : 720p (1280x720)
        // veryHigh : 1080p (1920x1080)
        // ultraHigh : 2160p (3840x2160)
        // max : 利用可能な最大の解像度
        ResolutionPreset.max);
    // コントローラーに設定されたカメラを初期化
    _initializeCameraController = _cameraController.initialize();
  }

  @override
  void dispose() {
    // ウィジェットが破棄されたタイミングで、カメラのコントローラを破棄する
    _cameraController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
      ),
      body: FutureBuilder<void>(
        future: _initializeCameraController,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            //
            return CameraPreview(_cameraController);
          } else {
            //
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.camera_alt),
        //
        onPressed: () async {
          try {
            //
            await _initializeCameraController;

            final path = join(
              (await getTemporaryDirectory()).path,
              '${DateTime.now()}.png',
            );

            //
            await _cameraController.takePicture(path);

            //
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CameraDisplay(imgPath: path),
              ),
            );
          } catch (e) {
            //
            print(e);
          }
        },
      ),
    );
  }
}
