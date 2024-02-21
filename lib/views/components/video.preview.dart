import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPreview extends StatefulWidget {
  @override
  _VideoPreviewState createState() => _VideoPreviewState();
}

class _VideoPreviewState extends State<VideoPreview> {
  late VideoPlayerController _controller;
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset(
      'assets/videos/learn_whylowerkneeshurt.mp4', // Replace with your asset video path
    )
      ..initialize().then((_) {
        setState(() {});
      }, onError: (error) {
        // Handle the error here
        print('Error initializing video player: $error');
      });


    _controller.addListener(() {
      if (_controller.value.position >= Duration(seconds: 10)) {
        _controller.seekTo(Duration.zero);
      }
    });
    
  }

  void _togglePlay() {
    setState(() {
      if (_controller.value.isPlaying) {
        _controller.pause();
        _isPlaying = false;
      } else {
        _controller.play();
        _isPlaying = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return _controller.value.isInitialized
        ? GestureDetector(
            onTap: _togglePlay,
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                AspectRatio(
                  aspectRatio: _controller.value.aspectRatio,
                  child: VideoPlayer(_controller),
                ),
                if (!_isPlaying)
                  Icon(
                    Icons.play_circle_outline,
                    color: Colors.white,
                    size: 64.0,
                  ),
              ],
            ),
          )
        : Center(child: CircularProgressIndicator());
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
