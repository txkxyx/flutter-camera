import 'package:camera/camera.dart';
import 'package:camera_app/provider/model/camera_model.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

import '../../main.dart';
import 'main.dart';

class CameraPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => CameraModel(),
        )
      ],
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Take Picture'),
        ),
        body: Column(
          children: [
            Expanded(
              child: CameraPreviewWidget(),
            ),
            Container(
              alignment: Alignment.center,
              height: 100,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [CameraReverseIcon(), CameraButton()],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class CameraPreviewWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var controller =
        Provider.of<CameraModel>(context, listen: true).cameraController;
    if (controller == null || !controller.value.isInitialized) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else {
      return CameraPreview(controller);
    }
  }
}

class CameraReverseIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<CameraModel>(context, listen: true);
    return IconButton(
        icon: _getReverseIcon(provider.cameraController),
        onPressed: () {
          provider.reverseCamera();
        });
  }

  Icon _getReverseIcon(CameraController controller) {
    if (controller == null) return const Icon(Icons.camera_rear);
    var lensDirection = controller.description.lensDirection;
    return lensDirection == CameraLensDirection.front
        ? const Icon(Icons.camera_rear)
        : const Icon(Icons.camera_front);
  }
}

class CameraButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var controller =
        Provider.of<CameraModel>(context, listen: true).cameraController;
    return IconButton(
      icon: const Icon(Icons.camera),
      onPressed: () async {
        try {
          final path = join((await getApplicationDocumentsDirectory()).path,
              '${DateTime.now()}.png');
          await controller.takePicture(path);
          await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CameraMainPage(),
              ));
        } catch (e) {
          print(e);
        }
      },
    );
  }
}
