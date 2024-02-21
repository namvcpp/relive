import 'package:dotted_line/dotted_line.dart';
import 'package:fit_worker/services/notification.service.dart';
import 'package:fit_worker/utils/constants.dart';
import 'package:fit_worker/utils/icon.dart';
import 'package:fit_worker/views/components/plan/plan.card.dart';
import 'package:fit_worker/views/components/plan/plan.list.after.dart';
import 'package:fit_worker/views/components/plan/plan.list.dart';
import 'package:fit_worker/views/screens/profile/profile.screen.dart';
import 'package:flutter/material.dart';
import 'package:fit_worker/views/app.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TodayScreen extends StatefulWidget {
  const TodayScreen({Key? key}) : super(key: key);

  @override
  _TodayScreenState createState() => _TodayScreenState();
}

class _TodayScreenState extends State<TodayScreen> {
  void _showTimePiker() {
    showTimePicker(context: context, initialTime: TimeOfDay.now())
      .then((value) => {
          NotificationService().sendNotification({
            "hour": value?.hour,
            "minute": value?.minute,
          })
        });
  }

  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double baseWidth = 390;
    double scale = MediaQuery.of(context).size.width / baseWidth;

    final theme = Theme.of(context);
    final myColors = theme.extension<MyColors>();

    return SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 2 * scale, vertical: 60 * scale),
        physics:
            const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 100 * scale,
              margin: EdgeInsets.only(left: 26 * scale, right: 18 * scale),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        child: Text(
                          "Today's Plan",
                          style: TextStyle(
                              color: myColors?.primaryColor,
                              fontWeight: FontWeight.w800,
                              fontSize: 30 * scale,
                              fontFamily: 'PlusSemiBold'),
                        ),
                      ),
                      const Spacer(),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const ProfileScreeen()));
                        },
                        child: Container(
                            height: 42 * scale,
                            width: 42 * scale,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(60 * scale),
                              border: Border.all(
                                color: myColors?.primaryColor ?? Colors.black,
                                width: 2,
                              ),
                            ),
                            child: Image.asset("assets/images/doctor1.png")),
                      )
                    ],
                  ),
                  SizedBox(height: 4 * scale),
                  Container(
                    child: Text(
                      "This is your plan for today based on your progress",
                      style: TextStyle(
                          color: myColors?.primaryColor,
                          fontWeight: FontWeight.normal,
                          fontSize: 14 * scale,
                          fontFamily: 'PlusRegular'),
                    ),
                  ),
                ],
              ),
            ),
            //Plan Part
            Container(
                height: 30 * scale,
                width: double.infinity,
                margin: EdgeInsets.only(left: 46 * scale, right: 18 * scale),
                alignment: Alignment.centerLeft,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: Text(
                        "Before work",
                        style: TextStyle(
                          color: myColors?.primaryColor,
                          fontWeight: FontWeight.w800,
                          fontSize: 18 * scale,
                          fontFamily: 'PlusSemiBold',
                        ),
                      ),
                    ),
                    const Spacer(),
                    Container(
                        child: GestureDetector(
                          onTap: _showTimePiker,
                          child: Container(
                            height: 26 * scale,
                            padding: EdgeInsets.symmetric(horizontal: 10 * scale),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25 * scale),
                              border: Border.all(
                                color: myColors?.secondaryColor ?? Colors.black,
                                width: 1,
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  padding: EdgeInsets.only(bottom: 2 * scale),
                                  child: Text(
                                    "Set Timer Here",
                                    style: TextStyle(
                                        color: myColors?.secondaryColor,
                                        fontWeight: FontWeight.normal,
                                        fontSize: 12 * scale,
                                        fontFamily: 'PlusRegular'),
                                  ),
                                ),
                                SizedBox(width: 4 * scale),
                                Container(
                                  color: Colors.transparent,
                                  width: 15,
                                  height: 15,
                                  child: clockIcon,
                                ),
                              ],
                            ),
                          ),
                        ))
                  ],
                )),
            Container(height: 300, child: PlanList()),
            SizedBox(height: 4 * scale),

            //Row two Container --> Container 1 margin-left & crossAxis start / Container 2 margin right & crossAxis end
            Container(
                height: 30 * scale,
                margin: EdgeInsets.only(left: 46 * scale, right: 18 * scale),
                alignment: Alignment.centerLeft,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: Text(
                        "Before lunch",
                        style: TextStyle(
                          color: myColors?.primaryColor,
                          fontWeight: FontWeight.w800,
                          fontSize: 18 * scale,
                          fontFamily: 'PlusSemiBold',
                        ),
                      ),
                    ),
                    const Spacer(),
                    Container(
                      child: GestureDetector(
                        onTap: _showTimePiker,
                        child: Container(
                          height: 24 * scale,
                          padding: EdgeInsets.symmetric(horizontal: 10 * scale),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25 * scale),
                            border: Border.all(
                              color: myColors?.secondaryColor ?? Colors.black,
                              width: 1,
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                  padding: EdgeInsets.only(bottom: 2 * scale),
                                  child: Text(
                                    "Set Timer Here",
                                    style: TextStyle(
                                        color: myColors?.secondaryColor,
                                        fontWeight: FontWeight.normal,
                                        fontSize: 12 * scale,
                                        fontFamily: 'PlusRegular'),
                                  ),
                                ),
                              SizedBox(width: 4 * scale),
                              Container(
                                color: Colors.transparent,
                                width: 15,
                                height: 15,
                                child: clockIcon,
                              ),
                            ],
                          ),
                        ),
                      ))
                  ],
                )),
            SizedBox(height: 4 * scale),

            Container(
                child: PlanCard(
              planCard: planCardsafter[0],
            )),

            SizedBox(height: 4 * scale),

            Container(
                height: 30 * scale,
                margin: EdgeInsets.only(left: 46 * scale, right: 18 * scale),
                alignment: Alignment.centerLeft,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(),
                    Text(
                      "Got time for more?",
                      style: TextStyle(
                        color: myColors?.primaryColor,
                        fontWeight: FontWeight.w800,
                        fontSize: 18 * scale,
                        fontFamily: 'PlusSemiBold',
                      ),
                    ),
                  ],
                )),

            SizedBox(height: 4 * scale),

            Container(
                child: PlanCard(
              planCard: planCardsafter[1],
            ))
          ],
        ),
    ));
  }
}
