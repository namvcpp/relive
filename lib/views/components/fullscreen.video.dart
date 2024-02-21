import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:fit_worker/views/app.dart';
import 'package:fit_worker/utils/icon.dart';


class FullScreenVideoScreen extends StatefulWidget {
  final String videoPath;

  const FullScreenVideoScreen({Key? key, required this.videoPath}) : super(key: key);

  @override
  _FullScreenVideoScreenState createState() => _FullScreenVideoScreenState();
}

class _FullScreenVideoScreenState extends State<FullScreenVideoScreen> {
  late VideoPlayerController _videoPlayerController;
  late ChewieController _chewieController;

  @override
  void initState() {
    super.initState();
    _videoPlayerController = VideoPlayerController.asset(widget.videoPath);
    _videoPlayerController.initialize().then((_) {
      setState(() {
        _chewieController = ChewieController(
          videoPlayerController: _videoPlayerController,
          autoPlay: true,
          looping: true,
          // Customize the other Chewie options you want here.
          materialProgressColors: ChewieProgressColors(
            playedColor: Color(0xff1B2C56),
            handleColor: Color(0xff1B2C56),
            backgroundColor: Color(0x22222222),
            bufferedColor: Color(0xF1F1F1F1),
          ),
          placeholder: Container(
          ),
          autoInitialize: true,
        );
      });
    });
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _chewieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double baseWidth = 390;
    double scale = MediaQuery.of(context).size.width / baseWidth;

    final theme = Theme.of(context);
    final myColors = theme.extension<MyColors>();

    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 40 * scale),
        child: Stack(
          children: [
            Center(
              child: _videoPlayerController.value.isInitialized
                  ? Chewie(
                      controller: _chewieController,
                    )
                  : CircularProgressIndicator(),
            ),
            Positioned(
              top: 0 * scale,
              left: 20 * scale,
              child: IconButton(
                icon: closeIcon, // Define this icon
                onPressed: () => Navigator.pop(context),
              ),
            ),
          ],
        ),
      )
    );
  }

}
