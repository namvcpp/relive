import 'package:fit_worker/utils/icon.dart';
import 'package:fit_worker/views/screens/exercise/exercise.flow.dart';
import 'package:flutter/material.dart';
import 'package:fit_worker/views/app.dart';

class HeelRaiseInstructionScreen extends StatelessWidget {
  const HeelRaiseInstructionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double baseWidth = 390;
    double scale = MediaQuery.of(context).size.width / baseWidth;

    final theme = Theme.of(context);
    final myColors = theme.extension<MyColors>();

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 200,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/squat.jpg"),
              fit: BoxFit.cover,
            ),
          ),
        ),
        leading: Align(
          alignment: Alignment.topLeft,
          child: Padding(
            padding: const EdgeInsets.only(left: 10),
            child: IconButton(
              icon: closeIcon,
              onPressed: () => ExerciseFlow.of(context).goToPreviousScreen(),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _buildTitle(context, scale, myColors),
          SizedBox(height: 20 * scale),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20 * scale),
            child: Row(
              children: [
                Text(
                  "1 of 3 exercises completed",
                  style: TextStyle(
                      color: myColors?.primaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 14 * scale,
                      fontFamily: 'PlusBold'),
                ),
                SizedBox(width: 20 * scale),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(top: 5),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: SizedBox(
                          height: 6,
                          child: LinearProgressIndicator(
                            value: 2 / 3,
                            color: myColors?.primaryColor,
                            backgroundColor: Colors.grey[300],
                          ),
                        )),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10 * scale),
          const Divider(
            color: Color(0xFFF1F1F1),
            thickness: 1.5,
            indent: 0,
            endIndent: 0,
          ),
          SizedBox(height: 10 * scale),
          _buildMiddle(context, scale, myColors),
          SizedBox(height: 15 * scale),
          const Divider(
            color: Color(0xFFF1F1F1),
            thickness: 1.5,
            indent: 0,
            endIndent: 0,
          ),
          SizedBox(height: 10 * scale),
          _buildHow(context, scale, myColors),
          SizedBox(height: 10 * scale),
          Divider(
            color: Color(0xFFF1F1F1),
            thickness: 1.5,
            indent: 0,
            endIndent: 0,
          ),
          SizedBox(height: 10 * scale),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 22 * scale),
            child: Row(
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Created by ",
                    style: TextStyle(
                        color: myColors?.primaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        fontFamily: 'PlusRegular'),
                  ),
                ),
                SizedBox(width: 5 * scale),
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Relive Experts Team",
                    style: TextStyle(
                        color: myColors?.primaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        fontFamily: 'PlusBold'),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 60 * scale),
        ],
      )),
    );
  }

  Widget _buildTitle(BuildContext context, double scale, MyColors? myColors) {
    return Container(
        padding: EdgeInsets.all(22 * scale),
        decoration: const BoxDecoration(
          color: Color(0xffEEF4F4),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Exercise 02",
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
                    "40 seconds",
                    style: TextStyle(
                        color: myColors?.primaryColor,
                        fontWeight: FontWeight.w400,
                        fontSize: 12 * scale,
                        fontFamily: 'PlusRegular'),
                  ),
                ),
              ],
            ),
            SizedBox(height: 8 * scale),
            Container(
              child: Text(
                "Heel Raise",
                style: TextStyle(
                    color: myColors?.primaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 22 * scale,
                    fontFamily: 'PlusBold'),
              ),
            ),
            SizedBox(height: 16 * scale),
            Center(
              child: ElevatedButton(
                style: ButtonStyle(
                    minimumSize: MaterialStateProperty.all(
                        Size(300 * scale, 54 * scale)),
                    alignment: Alignment.center,
                    backgroundColor:
                        MaterialStateProperty.all(myColors?.primaryColor)),
                onPressed: () => ExerciseFlow.of(context).goToNextScreen(),
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Text(
                    'Start Session',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16 * scale,
                        fontFamily: 'PlusBold'),
                  ),
                  SizedBox(width: 6 * scale),
                  Icon(
                    Icons.arrow_forward_outlined,
                    color: Colors.white,
                    size: 17 * scale,
                  ),
                ]),
              ),
            ),
            SizedBox(height: 4 * scale)
          ],
        ));
  }

  Widget _buildMiddle(BuildContext context, double scale, MyColors? myColors) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 22 * scale),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            alignment: Alignment.centerLeft,
            child: Text(
              "What to expect",
              style: TextStyle(
                  color: myColors?.primaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 20 * scale,
                  fontFamily: 'PlusBold'),
            ),
          ),
          SizedBox(height: 15 * scale),
          Container(
            alignment: Alignment.centerLeft,
            child: Text(
              "This exercise tackles these of your problems:",
              style: TextStyle(
                  color: myColors?.secondaryColor,
                  fontWeight: FontWeight.w400,
                  fontSize: 14 * scale,
                  fontFamily: 'PlusRegular'),
            ),
          ),
          SizedBox(height: 12 * scale),
          Row(children: [
            Container(
              margin: EdgeInsets.only(right: 8 * scale),
              padding: EdgeInsets.symmetric(
                  horizontal: 10 * scale, vertical: 5 * scale),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10 * scale),
                color: const Color(0xffEEF4F4),
              ),
              child: Text(
                "lower knee pain",
                style: TextStyle(
                    color: myColors?.primaryColor,
                    fontWeight: FontWeight.w400,
                    fontSize: 11 * scale,
                    fontFamily: 'PlusRegular'),
              ),
            ),
            Container(
              margin: EdgeInsets.only(right: 8 * scale),
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
                  fontSize: 11 * scale,
                ),
              ),
            ),
            // Container(
            //   margin: const EdgeInsets.only(left: 5),
            //   padding:
            //       const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
            //   decoration: BoxDecoration(
            //     borderRadius: BorderRadius.circular(10),
            //     color: const Color(0xffEEF4F4),
            //   ),
            //   child: const Text(
            //     "knee pain",
            //     style: TextStyle(
            //         color: myColors?.primaryColor,
            //         fontWeight: FontWeight.w400,
            //         fontSize: 10,
            //         fontFamily: 'PlusRegular'),
            //   ),
            // ),
          ]),
        ],
      ),
    );
  }

  Widget _buildHow(BuildContext context, double scale, MyColors? myColors) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 22 * scale),
      child: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            child: Text(
              "How does it work",
              style: TextStyle(
                  color: myColors?.primaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 20 * scale,
                  fontFamily: 'PlusBold'),
            ),
          ),
          SizedBox(height: 8 * scale),
          Container(
            padding: EdgeInsets.only(left: 6 * scale),
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: 6 * scale),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "•  First, stand with your feet shoulder-width apart and your arms down at your sides or held on anything to keep your balance.",
                    style: TextStyle(
                        color: myColors?.secondaryColor,
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        fontFamily: 'PlusSemiBold'),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 6 * scale),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "•  Second, slowly raised your knee until your thigh is parallel to the floor and heelraise for 15 seconds.",
                    style: TextStyle(
                        color: myColors?.secondaryColor,
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        fontFamily: 'PlusSemiBold'),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 6 * scale),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "•  Next, slowly lower your knee back down to the starting position and repeat the exercise for the other leg",
                    style: TextStyle(
                        color: myColors?.secondaryColor,
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        fontFamily: 'PlusSemiBold'),
                  ),
                ),
                // Container(
                //   margin: EdgeInsets.only(bottom: 6 * scale),
                //   alignment: Alignment.centerLeft,
                //   child: Text(
                //     "•  Finally, return to the starting position and repeat the exercise for the 10 times.",
                //     style: TextStyle(
                //         color: myColors?.secondaryColor,
                //         fontWeight: FontWeight.w400,
                //         fontSize: 14,
                //         fontFamily: 'PlusSemiBold'),
                //   ),
                // ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
