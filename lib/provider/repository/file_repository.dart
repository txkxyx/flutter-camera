import 'dart:io';

import 'package:path_provider/path_provider.dart';

class FileRepository {
  final String _path = '/image';

  Future<String> _getApplicationPath() async {
    var basePath = (await getApplicationDocumentsDirectory()).path;
    return basePath + _path;
  }

  Future<List<String>> getFiles() async {
    var dirPath = await _getApplicationPath();
    var dir = Directory(dirPath);
    if (!dir.existsSync()) dir.createSync();
    return dir.listSync().map((e) => e.path).toList();
  }
}
