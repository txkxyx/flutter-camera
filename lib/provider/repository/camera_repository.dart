import 'package:camera/camera.dart';

class CameraRepository {
  Future<List<CameraDescription>> getAvailableCamera() async {
    return await availableCameras();
  }
}
