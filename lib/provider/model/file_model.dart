import 'package:camera_app/provider/repository/file_repository.dart';
import 'package:flutter/material.dart';

class FileModel with ChangeNotifier {
  List<String> _files = [];
  List<String> get files => _files;

  final FileRepository _repository = FileRepository();

  FileModel() {
    _getFiles();
  }

  void _getFiles() async {
    var results = await _repository.getFiles();
    _files = results.isEmpty ? [] : results;
    notifyListeners();
  }
}
