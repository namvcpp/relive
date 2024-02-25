import 'package:fit_worker/providers/notifiers/app.notifier.dart';
import 'package:fit_worker/providers/notifiers/locale.notifier.dart';
import 'package:fit_worker/utils/icon.dart';
import 'package:fit_worker/views/app.dart';
import 'package:fit_worker/views/components/checkup/slider_custom.dart';
import 'package:fit_worker/views/screens/exercise/exercise.flow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:provider/provider.dart';

class CheckUp extends StatefulWidget {
  const CheckUp({Key? key}) : super(key: key);

  @override
  _CheckUpState createState() => _CheckUpState();
}

class _CheckUpState extends State<CheckUp> {
  @override
  Widget build(BuildContext context) {
    double baseWidth = 390;
    double scale = MediaQuery.of(context).size.width / baseWidth;

    final theme = Theme.of(context);
    final myColors = theme.extension<MyColors>();
    final evalution = [
      {
        'title': 'Excellent',
        'description': 'I feel nearly no pain!',
        'icon': excellentIcon,
        'value': 80
      },
      {
        'title': 'Good',
        'description': 'Don’t bother me today',
        'icon': goodIcon,
        'value': 60
      },
      {
        'title': 'Fair',
        'description': 'I’m still able to manage',
        'icon': fairIcon,
        'value': 40
      },
      {
        'title': 'Poor',
        'description': 'It affects me badly',
        'icon': poorIcon,
        'value': 20
      },
      {
        'title': 'Worst',
        'description': 'Driving me insane today',
        'icon': worstIcon,
        'value': 0
      },
    ];

    return Consumer<LocalesNotifier>(builder: (context, notifier, _) {
      return Scaffold(
        appBar: AppBar(
          title: Container(
            margin: EdgeInsets.only(top: 10 * scale, bottom: 10 * scale),
            child: Text(
              'Post-session Checkup',
              style: TextStyle(
                  color: myColors?.primaryColor,
                  fontSize: 17 * scale,
                  fontFamily: 'PlusBold'),
            ),
          ),
          centerTitle: true,
        ),
        body: Column(children: [
          Container(
            margin: EdgeInsets.only(top: 10 * scale, bottom: 30 * scale),
            child: Text(
              'How is your pain now?',
              style: TextStyle(
                  color: myColors?.primaryColor,
                  fontSize: 28 * scale,
                  fontFamily: 'PlusBold'),
            ),
          ),
          Row(
            children: [
              Container(
                height: 480 * scale,
                child: Column(
                  //make the children spaced between evenly & start from the start
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: evalution
                      .map((e) => Column(
                            children: [
                              Container(
                                margin: EdgeInsets.only(left: 20 * scale),
                                child: Text(
                                  e['title'] as String,
                                  style: TextStyle(
                                      color: notifier.evaluation == 0 &&
                                              e['title'] == 'Worst'
                                          ? myColors?.worstColor
                                          : notifier.evaluation == 20 &&
                                                  e['title'] == 'Poor'
                                              ? myColors?.poorColor
                                              : notifier.evaluation == 40 &&
                                                      e['title'] == 'Fair'
                                                  ? myColors?.fairColor
                                                  : notifier.evaluation == 60 &&
                                                          e['title'] == 'Good'
                                                      ? myColors?.goodColor
                                                      : notifier.evaluation ==
                                                                  80 &&
                                                              e['title'] ==
                                                                  'Excellent'
                                                          ? myColors
                                                              ?.excellentColor
                                                          : myColors
                                                              ?.primaryColor,
                                      fontSize: 26 * scale,
                                      fontFamily: 'PlusBold'),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                    left: 25 * scale, bottom: 30 * scale),
                                child: Text(
                                  e['description'] as String,
                                  style: TextStyle(
                                      color: myColors?.primaryColor,
                                      fontSize: 15 * scale,
                                      fontFamily: 'PlusSemiBold'),
                                ),
                              ),
                            ],
                          ))
                      .toList(),
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                    left: 20 * scale, bottom: 35 * scale, top: 10 * scale),
                height: 470 * scale,
                child: RotatedBox(quarterTurns: 3, child: SliderCustomThumb()),
              ),
              Container(
                height: 500 * scale,
                margin: EdgeInsets.only(top: 5 * scale),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: evalution
                      .map((e) => Container(
                          margin: EdgeInsets.only(
                              left: 20 * scale, bottom: 35 * scale),
                          child: Container(
                            width: e['value'] == notifier.evaluation
                                ? 65 * scale
                                : 55 * scale,
                            height: e['value'] == notifier.evaluation
                                ? 65 * scale
                                : 55 * scale,
                            child: e['icon'] as Widget,
                          )))
                      .toList(),
                ),
              )
            ],
          ),
          Container(
              margin: EdgeInsets.only(top: 30 * scale, left: 200 * scale),
              padding: EdgeInsets.only(left: 20 * scale, right: 20 * scale),
              height: 50 * scale,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                border: Border.all(color: myColors?.primaryColor as Color),
                color: myColors?.primaryColor,
              ),
              child: TextButton(
                onPressed: () {
                  ExerciseFlow.of(context).goToNextScreen();
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: myColors?.primaryColor),
                child: Text(
                  'Next',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20 * scale,
                      fontFamily: 'PlusSemiBold'),
                ),
              )),
        ]),
      );
    });
  }
}
