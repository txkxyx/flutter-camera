import 'dart:io';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoDisplay extends StatefulWidget {
  final String videoPath;

  VideoDisplay({Key key, this.videoPath}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _VideoDisplayState();
}

class _VideoDisplayState extends State<VideoDisplay> {
  VideoPlayerController _videoPlayerController;
  VoidCallback videoPlayerListener;

  @override
  void initState(){
    print(widget.videoPath);
    _videoPlayerController = VideoPlayerController.file(File(widget.videoPath));

    videoPlayerListener = () {
      if(_videoPlayerController != null && _videoPlayerController.value.size != null){
        if(mounted) setState(() {});
        _videoPlayerController.removeListener(videoPlayerListener);
      }
    };

    _videoPlayerController.addListener(videoPlayerListener);

    _videoPlayerController.initialize();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('VideoPlayer'),
      ),
      body: Center(
        child: _videoPlayerController.value.initialized
            ? AspectRatio(
                aspectRatio: _videoPlayerController.value.aspectRatio,
                child: VideoPlayer(_videoPlayerController),
              )
            : Container(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _videoPlayerController.value.isPlaying
                ? _videoPlayerController.pause()
                : _videoPlayerController.play();
          });
        },
        child: Icon(_videoPlayerController.value.isPlaying
            ? Icons.pause
            : Icons.play_arrow),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _videoPlayerController.dispose();
  }
}
