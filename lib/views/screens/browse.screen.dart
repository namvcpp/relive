import 'package:fit_worker/views/screens/exercise/squat/squat_pose_detector.screen.dart';
import 'package:flutter/material.dart';
import 'package:fit_worker/views/components/search_bar.dart';
import 'package:fit_worker/utils/icon.dart';
import 'package:fit_worker/views/app.dart';

class BrowseScreen extends StatelessWidget {
  const BrowseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double baseWidth = 390;
    double scale = MediaQuery.of(context).size.width / baseWidth;

    final theme = Theme.of(context);
    final myColors = theme.extension<MyColors>();

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 60 * scale),
            Align(
              alignment: Alignment.center,
              child: Text(
                'Browse',
                style: TextStyle(
                    color: myColors?.primaryColor,
                    fontWeight: FontWeight.w800,
                    fontSize: 18 * scale,
                    fontFamily: "PlusSemiBold"),
              ),
            ),
            SizedBox(height: 24 * scale),
            _buildFirstCard(context, scale, myColors),
            SizedBox(height: 35 * scale),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 24 * scale),
              child: Text(
                'Easy to do during work',
                style: TextStyle(
                  color: myColors?.primaryColor,
                  fontWeight: FontWeight.w800,
                  fontSize: 24 * scale,
                  fontFamily: "PlusSemiBold",
                ),
              ),
            ),
            SizedBox(height: 10 * scale),
            _buildCards(scale, Color(0xFFB9E9FD), myColors, "Chest stretch",
                'assets/images/lowebody-workout.png', "03 motions"),
            SizedBox(height: 25 * scale),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 24 * scale),
              child: Text(
                'Relaxation therapy',
                style: TextStyle(
                  color: myColors?.primaryColor,
                  fontWeight: FontWeight.w800,
                  fontSize: 24 * scale,
                  fontFamily: "PlusSemiBold",
                ),
              ),
            ),
            _buildCards(scale, Color(0xffC8FFC7), myColors, "Music therapy",
                'assets/images/therapy1.png', "05 mins"),
            SizedBox(height: 25 * scale),
          ],
        ),
      ),
    );
  }

  Widget _buildFirstCard(
    BuildContext context,
    double scale,
    MyColors? myColors,
  ) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 24 * scale),
      height: 230 * scale,
      padding:
          EdgeInsets.symmetric(horizontal: 24 * scale, vertical: 14 * scale),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20 * scale),
        color: const Color(0xFFFCEABC),
      ),
      alignment: Alignment.centerLeft,
      child: Stack(
        children: [
          Row(
            children: [
              Expanded(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 8 * scale,
                    ),
                    Text(
                      'Understand how our app works?',
                      style: TextStyle(
                        color: myColors?.primaryColor,
                        fontWeight: FontWeight.w800,
                        fontSize: 22 * scale,
                        fontFamily: "PlusSemiBold",
                      ),
                    ),
                    SizedBox(height: 10 * scale),
                    Row(
                      children: [
                        Container(
                          color: Colors.transparent,
                          height: 12 * scale,
                          width: 12 * scale,
                          child: fitnessIcon,
                        ),
                        SizedBox(width: 10 * scale),
                        Text(
                          '03 Videos',
                          style: TextStyle(
                            color: myColors?.primaryColor,
                            fontSize: 14 * scale,
                            fontFamily: 'PlusSemiBold',
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 5 * scale),
                    Text(
                      'Acknowledge our cutting-edge technology to solve the problems',
                      style: TextStyle(
                        color: myColors?.secondaryColor,
                        fontSize: 12 * scale,
                        fontFamily: 'PlusRegular',
                      ),
                    ),
                    SizedBox(height: 15 * scale),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25 * scale),
                        color: myColors?.primaryColor,
                      ),
                      height: 45 * scale,
                      width: 230 * scale,
                      child: TextButton(
                        onPressed: () {},
                        child: Text(
                          'Begin watching',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w800,
                            fontSize: 14 * scale,
                            fontFamily: 'PlusSemiBold',
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const Expanded(flex: 1, child: Text(""))
            ],
          )
        ],
      ),
    );
  }

  Widget _buildCards(double scale, Color backgroundColor, MyColors? myColors,
      String title, String image, String length) {
    return Container(
      height: 160 * scale,
      margin: EdgeInsets.only(left: 24 * scale),
      child: ListView(
          scrollDirection: Axis.horizontal,
          children: List<Widget>.generate(
            3,
            (index) => Stack(
              children: <Widget>[
                Container(
                  width: 165 * scale,
                  height: 160 * scale,
                  margin: EdgeInsets.only(right: 10 * scale),
                  padding: EdgeInsets.symmetric(vertical: 10 * scale),
                  child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(backgroundColor),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25 * scale),
                          ),
                        ),
                        elevation: MaterialStateProperty.all(0),
                      ),
                      onPressed: () {
                        print('hello');
                      },
                      child: Column(
                        children: [
                          SizedBox(height: 10 * scale),
                          Align(
                            alignment: Alignment.center,
                            child: Text(
                              title,
                              style: TextStyle(
                                color: myColors?.primaryColor,
                                fontWeight: FontWeight.w800,
                                fontSize: 14 * scale,
                                fontFamily: "PlusSemiBold",
                              ),
                            ),
                          ),
                          Container(
                              padding: EdgeInsets.all(10 * scale),
                              child: Image.asset(image)),
                        ],
                      )),
                ),
                Positioned(
                    bottom: 20 * scale,
                    left: 12 * scale,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 8 * scale, vertical: 5 * scale),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15 * scale),
                        color: Colors.white,
                      ),
                      child: IntrinsicWidth(
                        child: Row(
                          children: [
                            Container(
                              color: Colors.transparent,
                              height: 12 * scale,
                              width: 12 * scale,
                              child: fitnessIcon,
                            ),
                            SizedBox(width: 5 * scale),
                            Text(
                              length,
                              style: TextStyle(
                                color: myColors?.primaryColor,
                                fontSize: 12 * scale,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'PlusSemiBold',
                              ),
                            ),
                          ],
                        ),
                      ),
                    )),
              ],
            ),
          )),
    );
  }
}
