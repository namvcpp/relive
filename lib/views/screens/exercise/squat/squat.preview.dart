import 'package:fit_worker/utils/icon.dart';
import 'package:fit_worker/views/screens/exercise/exercise.flow.dart';
import 'package:fit_worker/views/screens/exercise/squat/squat_pose_detector.screen.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:fit_worker/views/app.dart';

class SquatPreviewScreen extends StatefulWidget {
  const SquatPreviewScreen({Key? key}) : super(key: key);

  @override
  _SquatPreviewScreenState createState() => _SquatPreviewScreenState();
}

class _SquatPreviewScreenState extends State<SquatPreviewScreen> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset('assets/videos/squat1.mp4')
      ..initialize().then((_) {
        _controller.play();
        _controller.setLooping(true);
        setState(() {});
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double baseWidth = 390;
    double scale = MediaQuery.of(context).size.width / baseWidth;

    final theme = Theme.of(context);
    final myColors = theme.extension<MyColors>();

    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 500,
          flexibleSpace: Container(
            child: _controller.value.isInitialized
                ? AspectRatio(
                    aspectRatio: _controller.value.aspectRatio,
                    child: VideoPlayer(_controller),
                  )
                : const Center(child: CircularProgressIndicator()),
          ),
          leading: Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 10),
              child: IconButton(
                icon: backIcon,
                onPressed: () => ExerciseFlow.of(context).goToPreviousScreen(),
              ),
            ),
          ),
        ),
        body: Container(
          padding: EdgeInsets.all(22 * scale),
          decoration: const BoxDecoration(
            color: Color(0xffEEF4F4),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Exercise 01",
                        style: TextStyle(
                          color: myColors?.primaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 14 * scale,
                          fontFamily: 'PlusBold',
                        ),
                      ),
                      Spacer(),
                      Container(
                        // margin: EdgeInsets.only(left: 5, top: 20),
                        padding: EdgeInsets.symmetric(
                            horizontal: 10 * scale, vertical: 5 * scale),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10 * scale),
                          color: Colors.white,
                        ),
                        child: Text(
                          "03 mins",
                          style: TextStyle(
                              color: myColors?.primaryColor,
                              fontWeight: FontWeight.w400,
                              fontSize: 12 * scale,
                              fontFamily: 'PlusRegular'),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 6 * scale,
                  ),
                  Container(
                    child: Text(
                      "Arm-raised Squat",
                      style: TextStyle(
                          color: myColors?.primaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 24 * scale,
                          fontFamily: 'PlusBold'),
                    ),
                  ),
                  SizedBox(
                    height: 15 * scale,
                  ),
                  Center(
                    child: ElevatedButton(
                        style: ButtonStyle(
                            minimumSize: MaterialStateProperty.all(
                                Size(300 * scale, 54 * scale)),
                            alignment: Alignment.center,
                            backgroundColor: MaterialStateProperty.all(
                                myColors?.primaryColor)),
                        onPressed: () {
                          ExerciseFlow.of(context).goToNextScreen();
                        },
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Skip guide video',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontFamily: 'PlusSemiBold'),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Icon(
                              Icons.arrow_forward_outlined,
                              color: Colors.white,
                              size: 17,
                            ),
                          ],
                        )),
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}
