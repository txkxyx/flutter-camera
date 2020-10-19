import 'package:camera/camera.dart';
import 'package:camera_app/provider/repository/camera_repository.dart';
import 'package:flutter/material.dart';

class CameraModel with ChangeNotifier {
  CameraController _cameraController;
  CameraController get cameraController => _cameraController;

  List<CameraDescription> _cameras;
  List<CameraDescription> get cameras => _cameras;

  int _index;
  int get index => _index;

  final CameraRepository _repository = CameraRepository();

  CameraModel() {
    _index = 0;
    _initCameraModel();
    notifyListeners();
  }

  void reverseCamera() async {
    _index = _index == 1 ? 0 : 1;
    _initCameraController(_cameras[_index]);
    notifyListeners();
  }

  void _initCameraModel() async {
    _cameras = await _repository.getAvailableCamera();
    _initCameraController(_cameras[_index]);
  }

  void _initCameraController(CameraDescription description) async {
    if (_cameraController != null) await _cameraController.dispose();
    _cameraController = CameraController(description, ResolutionPreset.max);

    await _cameraController.initialize();
  }
}
