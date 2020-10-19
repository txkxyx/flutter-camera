import 'package:camera/camera.dart';
import 'package:camera_app/media/cameraHome.dart';
import 'package:camera_app/media/multiCameraHome.dart';
import 'package:camera_app/media/videoHome.dart';
import 'package:flutter/material.dart';

import 'provider/ui/main.dart';

Future<void> main() async {
  // runAppが実行される前に、cameraプラグインを初期化
  WidgetsFlutterBinding.ensureInitialized();

  // デバイスで使用可能なカメラの一覧を取得する
  final cameras = await availableCameras();

  // 利用可能なカメラの一覧から、指定のカメラを取得する
  final firstCamera = cameras.first;

  runApp(MyApp(camera: firstCamera));
}

class MyApp extends StatelessWidget {
  final CameraDescription camera;
  const MyApp({Key key, @required this.camera}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(
        camera: camera,
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final CameraDescription camera;
  const MyHomePage({Key key, @required this.camera}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Camera Example'),
      ),
      body: Wrap(
        children: [
          RaisedButton(
              child: const Text('Camera'),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return CameraHome(
                    camera: camera,
                  );
                }));
              }),
          RaisedButton(
              child: const Text('Multi Camera'),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return MultiCameraHome();
                }));
              }),
          RaisedButton(
              child: const Text('Multi Video'),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return VideoHome();
                }));
              }),
          RaisedButton(
            child: const Text('Provider Camera'),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return CameraMainPage();
              }));
            },
          )
        ],
      ),
    );
  }
}
