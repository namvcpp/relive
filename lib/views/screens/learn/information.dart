import 'package:fit_worker/views/screens/exercise/squat/squat.instruction.dart';
import 'package:fit_worker/views/components/video.preview.dart';
import 'package:flutter/material.dart';
import 'package:fit_worker/utils/icon.dart';
import 'package:fit_worker/views/components/fullscreen.video.dart';
import 'package:fit_worker/views/app.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LearnInformationScreen extends StatefulWidget {
  const LearnInformationScreen({
    super.key,
  });

  @override
  _LearnInformationScreenState createState() => _LearnInformationScreenState();
}

class _LearnInformationScreenState extends State<LearnInformationScreen> {
  late String selected;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double baseWidth = 390;
    double scale = MediaQuery.of(context).size.width / baseWidth;

    final theme = Theme.of(context);
    final myColors = theme.extension<MyColors>();

    return Scaffold(
      body: Column(
        children: [
          Container(
              color: const Color(0xFFFCEABC),
              padding: EdgeInsets.only(top: 20 * scale),
              height: 270 * scale,
              child: Stack(
                children: [
                  SizedBox(
                    height: double.infinity,
                    width: double.infinity,
                    child: VideoPreview(),
                  ),
                  Positioned(
                    top: 20 * scale,
                    left: 10 * scale,
                    child: IconButton(
                      icon: closeIcon, // Define this icon
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                ],
              )),
          Row(children: [
            Container(
                margin: EdgeInsets.only(left: 20 * scale, top: 20 * scale),
                padding: EdgeInsets.symmetric(
                    horizontal: 10 * scale, vertical: 7 * scale),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20 * scale),
                  color: Color(0xffEEF4F4),
                ),
                child: Row(children: [
                  Container(
                    color: Colors.transparent,
                    height: 12 * scale,
                    width: 12 * scale,
                    child: fitnessIcon,
                  ),
                  const SizedBox(width: 5),
                  Text(
                    "Lower Knee",
                    style: TextStyle(
                        color: myColors?.primaryColor,
                        fontSize: 10 * scale,
                        fontFamily: 'PlusRegular'),
                  ),
                ])),
            // Container(
            //     margin: const EdgeInsets.only(left: 7, top: 20),
            //     padding: const EdgeInsets.only(
            //         left: 10, top: 7, bottom: 7, right: 12),
            //     decoration: BoxDecoration(
            //       borderRadius: BorderRadius.circular(20),
            //       color: const Color(0xffEEF4F4),
            //     ),
            //     child: Row(children: [
            //       Container(
            //         child: fitnessIcon,
            //         color: Colors.transparent,
            //         height: 12,
            //         width: 12,
            //       ),
            //       const SizedBox(width: 5),
            //       const Text(
            //         "Knee",
            //         style: TextStyle(
            //             color: myColors?.primaryColor,
            //             fontSize: 10,
            //             fontFamily: 'PlusSemiBold'),
            //       ),
            //     ])),
          ]),
          SizedBox(height: 10 * scale),
          Container(
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.only(left: 20 * scale),
            child: LocaleText(
              AppLocalizations.of(context)!.info_screen_title,
              style: TextStyle(
                  color: myColors?.primaryColor,
                  fontSize: 26 * scale,
                  fontFamily: 'PlusBold'),
            ),
          ),
          SizedBox(
            height: 14 * scale,
          ),
          Container(
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.only(left: 20 * scale),
              child: Text(
                AppLocalizations.of(context)!.info_screen_subtitle,
                style: TextStyle(
                  color: myColors?.secondaryColor,
                  fontWeight: FontWeight.normal,
                  fontFamily: "PlusRegular",
                  fontSize: 14 * scale,
                ),
              )),
          SizedBox(height: 15 * scale),
          Row(children: [
            SizedBox(width: 20 * scale),
            Container(
              margin: EdgeInsets.only(right: 5 * scale),
              padding: EdgeInsets.symmetric(
                  horizontal: 10 * scale, vertical: 5 * scale),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10 * scale),
                color: Color(0xffEEF4F4),
              ),
              child: Text(
                "lower knee pain",
                style: TextStyle(
                  color: myColors?.primaryColor,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'PlusRegular',
                  fontSize: 10 * scale,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(right: 5 * scale),
              padding: EdgeInsets.symmetric(
                  horizontal: 10 * scale, vertical: 5 * scale),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10 * scale),
                color: Color(0xffEEF4F4),
              ),
              child: Text(
                "moderate level",
                style: TextStyle(
                  color: myColors?.primaryColor,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'PlusRegular',
                  fontSize: 10 * scale,
                ),
              ),
            ),
          ]),
          SizedBox(height: 15 * scale),
          const Divider(
            color: Color(0xFFF1F1F1),
            thickness: 1.5,
            indent: 0,
            endIndent: 0,
          ),
          SizedBox(height: 8 * scale),
          Container(
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.only(left: 20 * scale),
            child: Text(
              AppLocalizations.of(context)!.info_screen_step,
              style: TextStyle(
                  color: myColors?.primaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 20 * scale,
                  fontFamily: 'PlusBold'),
            ),
          ),
          SizedBox(height: 10 * scale),
          Container(
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.only(left: 22 * scale),
            child: Text(
              AppLocalizations.of(context)!.info_screen_step_1,
              style: TextStyle(
                  color: myColors?.primaryColor,
                  fontWeight: FontWeight.w400,
                  fontSize: 14 * scale,
                  fontFamily: 'PlusRegular'),
            ),
          ),
          SizedBox(height: 5 * scale),
          Container(
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.only(left: 22 * scale),
            child: Text(
              AppLocalizations.of(context)!.info_screen_step_2,
              style: TextStyle(
                  color: myColors?.primaryColor,
                  fontWeight: FontWeight.w400,
                  fontSize: 14 * scale,
                  fontFamily: 'PlusRegular'),
            ),
          ),
          SizedBox(height: 5 * scale),
          Container(
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.only(left: 22 * scale),
            child: Text(
              AppLocalizations.of(context)!.info_screen_step_3,
              style: TextStyle(
                  color: myColors?.primaryColor,
                  fontWeight: FontWeight.w400,
                  fontSize: 14 * scale,
                  fontFamily: 'PlusRegular'),
            ),
          ),
          SizedBox(height: 15 * scale),
          const Divider(
            color: Color(0xFFF1F1F1),
            thickness: 1.5,
            indent: 0,
            endIndent: 0,
          ),
          SizedBox(height: 8 * scale),
          Row(
            children: [
              Container(
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.only(left: 20 * scale),
                child: Text(
                  "Created by ",
                  style: TextStyle(
                      color: myColors?.primaryColor,
                      fontSize: 20 * scale,
                      fontFamily: 'PlusRegular'),
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Relive Experts Team",
                  style: TextStyle(
                      color: myColors?.primaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 20 * scale,
                      fontFamily: 'PlusBold'),
                ),
              ),
            ],
          ),
          SizedBox(height: 15 * scale),
          const Divider(
            color: Color(0xFFF1F1F1),
            thickness: 1.5,
            indent: 0,
            endIndent: 0,
          ),
          Expanded(
              child: Container(
            height: double.infinity,
            alignment: Alignment.center,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 80 * scale,
                  child: Center(
                    child: ElevatedButton(
                        style: ButtonStyle(
                          minimumSize: MaterialStateProperty.all(
                              Size(120 * scale, 85 * scale)),
                          maximumSize: MaterialStateProperty.all(
                              Size(170 * scale, 85 * scale)),
                          alignment: Alignment.center,
                          backgroundColor:
                              MaterialStateProperty.all(myColors?.primaryColor),
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  30 * scale), // Set your desired radius here
                            ),
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const FullScreenVideoScreen(
                                    videoPath:
                                        'assets/videos/learn_whylowerknees.mp4')),
                          );
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              AppLocalizations.of(context)!.info_screen_watch,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16 * scale,
                                  fontFamily: 'PlusSemiBold'),
                            ),
                          ],
                        )),
                  ),
                ),
                SizedBox(
                  width: 15 * scale,
                ),
                Container(
                  height: 80 * scale,
                  child: Center(
                    child: ElevatedButton(
                        style: ButtonStyle(
                          minimumSize: MaterialStateProperty.all(
                              Size(120 * scale, 85 * scale)),
                          maximumSize: MaterialStateProperty.all(
                              Size(170 * scale, 85 * scale)),
                          alignment: Alignment.center,
                          backgroundColor:
                              MaterialStateProperty.all(myColors?.primaryColor),
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  30 * scale), // Set your desired radius here
                            ),
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const SquatInstructionScreen()),
                          );
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              AppLocalizations.of(context)!.info_screen_listen,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16 * scale,
                                  fontFamily: 'PlusSemiBold'),
                            ),
                          ],
                        )),
                  ),
                ),
              ],
            ),
          )),
          SizedBox(height: 20 * scale)
        ],
      ),
    );
  }
}
