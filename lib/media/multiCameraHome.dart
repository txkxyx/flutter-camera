import 'dart:io';

import 'package:camera/camera.dart';
import 'package:camera_app/media/cameraDisplay.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' show join;
import 'package:path_provider/path_provider.dart';

class MultiCameraHome extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MultiCameraState();
}

class MultiCameraState extends State<MultiCameraHome> {
  CameraController _cameraController;
  List<CameraDescription> cameras;
  int selectedCameraIndex;

  @override
  void initState() {
    super.initState();

    availableCameras().then((availableCameras) {
      cameras = availableCameras;

      if (cameras.length > 0) {
        setState(() {
          selectedCameraIndex = 0;
        });
      }

      _initCameraController(cameras[selectedCameraIndex]);
    });
  }

  Future<void> _initCameraController(
      CameraDescription cameraDescription) async {
    if (_cameraController != null) {
      await _cameraController.dispose();
    }

    _cameraController =
        CameraController(cameraDescription, ResolutionPreset.max);

    _cameraController.addListener(() {
      if (mounted) {
        setState(() {});
      }

      if (_cameraController.value.hasError) {
        print('Camera Error');
      }
    });

    try {
      await _cameraController.initialize();
    } catch (e) {
      print(e);
    }
  }

  Widget _cameraPreviewWidget() {
    if (_cameraController == null || !_cameraController.value.isInitialized) {
      return const Center(child: CircularProgressIndicator());
    } else {
      return CameraPreview(_cameraController);
    }
  }

  Icon _getReserseCameraIcon() {
    if (_cameraController == null) return const Icon(Icons.camera_rear);
    CameraLensDirection lensDirection =
        _cameraController.description.lensDirection;

    return lensDirection == CameraLensDirection.front
        ? const Icon(Icons.camera_rear)
        : const Icon(Icons.camera_front);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(''),
        ),
        body: Column(
          children: [
            Expanded(
              child: _cameraPreviewWidget(),
            ),
            Container(
                alignment: Alignment.center,
                height: 100,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                        icon: _getReserseCameraIcon(),
                        onPressed: () {
                          selectedCameraIndex =
                              selectedCameraIndex == 1 ? 0 : 1;
                          _initCameraController(cameras[selectedCameraIndex]);
                        }),
                    IconButton(
                        icon: const Icon(Icons.camera),
                        onPressed: () async {
                          try {
                            // await _cameraController.initialize();

                            final path = join(
                                (await getTemporaryDirectory()).path,
                                '${DateTime.now()}.png');

                            await _cameraController.takePicture(path);

                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        CameraDisplay(imgPath: path),
                                    fullscreenDialog: true));
                          } catch (e) {
                            print(e);
                          }
                        }),
                  ],
                ))
          ],
        ));
  }
}
