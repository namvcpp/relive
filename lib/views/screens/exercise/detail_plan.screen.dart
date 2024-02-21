import 'package:fit_worker/views/screens/exercise/session.flow.dart';
import 'package:flutter/material.dart';
import 'package:fit_worker/utils/icon.dart';
import 'package:fit_worker/utils/image.dart';
import 'package:fit_worker/views/app.dart';

class DetailPlanScreen extends StatefulWidget {
  const DetailPlanScreen({
    super.key,
  });

  @override
  _DetailPlanScreenState createState() => _DetailPlanScreenState();
}

class _DetailPlanScreenState extends State<DetailPlanScreen> {
  late String selected;
  final imagesList = [
    squadImg,
    squadImg,
    squadImg,
  ];
  @override
  void initState() {
    super.initState();
    selected = '8 mins';
  }

  @override
  Widget build(BuildContext context) {
    double baseWidth = 390;
    double scale = MediaQuery.of(context).size.width / baseWidth;

    final theme = Theme.of(context);
    final myColors = theme.extension<MyColors>();

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 200 * scale,
        backgroundColor: myColors?.exerciseColor,
        leading: Align(
          alignment: Alignment.topLeft,
          child: Padding(
            padding: const EdgeInsets.only(left: 10),
            child: IconButton(
              icon: closeIcon,
              onPressed: () => Navigator.pop(context),
            ),
          ),
        ),
        title: Align(
          alignment: Alignment.bottomCenter,
          child: SizedBox(
            height: 200 * scale,
            width: 250 * scale,
            child: exerciseIcon,
          ),
        ),
      ),
      body: ListView(
        children: [
          _buildIntro(context, scale, myColors),
          SizedBox(height: 14 * scale),
          const Divider(
            color: Color(0xFFF1F1F1),
            thickness: 1.5,
            indent: 0,
            endIndent: 0,
          ),
          SizedBox(height: 14 * scale),
          _buildInfo(context, scale, myColors),
          SizedBox(height: 14 * scale),
          const Divider(
            color: Color(0xFFF1F1F1),
            thickness: 1.5,
            indent: 0,
            endIndent: 0,
          ),
          Expanded(
              child: Stack(
            children: [
              Opacity(
                opacity: 0.5,
                child: SizedBox(
                  height: 145,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: imagesList.length,
                    itemBuilder: (context, index) {
                      return Padding(
                          padding: const EdgeInsets.only(top: 10, left: 20),
                          child: Image.asset(
                            "assets/images/squad.jpeg",
                            // width: 200,
                            // height: 200,
                          ));
                    },
                  ),
                ),
              ),
              Positioned(
                bottom: 60,
                left: 0,
                right: 0,
                child: Center(
                  child: ElevatedButton(
                      style: ButtonStyle(
                          minimumSize:
                              MaterialStateProperty.all(const Size(220, 55)),
                          maximumSize:
                              MaterialStateProperty.all(const Size(320, 85)),
                          alignment: Alignment.center,
                          backgroundColor: MaterialStateProperty.all(
                              const Color(0xFF1B2C56))),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const ExerciseSessionFlow()),
                        );
                      },
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Start Session',
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
              ),
            ],
          )),
        ],
      ),
    );
  }

  Widget _buildIntro(BuildContext context, double scale, MyColors? myColors) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20 * scale),
      child: Column(
        children: [
          SizedBox(height: 20 * scale),
          Row(children: [
            Container(
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
                  SizedBox(width: 5 * scale),
                  Text(
                    "Lower Knee",
                    style: TextStyle(
                        color: Color(0xff1B2C56),
                        fontSize: 10 * scale,
                        fontFamily: 'PlusRegular'),
                  ),
                ])),
          ]),
          SizedBox(height: 12 * scale),
          Container(
            alignment: Alignment.centerLeft,
            child: Text(
              "Today recovery session",
              style: TextStyle(
                  color: myColors?.primaryColor,
                  fontSize: 24 * scale,
                  fontFamily: 'PlusBold'),
            ),
          ),
          SizedBox(height: 14 * scale),
          Container(
              alignment: Alignment.centerLeft,
              child: Text(
                "Created only for you, based on what you told us: ",
                style: TextStyle(
                  color: myColors?.secondaryColor,
                  fontWeight: FontWeight.normal,
                  fontFamily: "PlusRegular",
                  fontSize: 14 * scale,
                ),
              )),
          SizedBox(height: 18 * scale),
          Row(children: [
            Container(
              margin: EdgeInsets.only(right: 6 * scale),
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
                  fontFamily: 'PlusRegular',
                  fontSize: 10 * scale,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(right: 6 * scale),
              padding: EdgeInsets.symmetric(
                  horizontal: 10 * scale, vertical: 5 * scale),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10 * scale),
                color: const Color(0xffEEF4F4),
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
          ])
        ],
      ),
    );
  }

  Widget _buildInfo(BuildContext context, double scale, MyColors? myColors) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20 * scale),
      child: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            child: Text(
              "Session lengths for today",
              style: TextStyle(
                color: myColors?.primaryColor,
                fontWeight: FontWeight.bold,
                fontFamily: 'PlusBold',
                fontSize: 18,
              ),
            ),
          ),
          SizedBox(height: 6 * scale),
          Container(
            alignment: Alignment.centerLeft,
            child: Text(
              "Select your session length and preview the exercises below",
              style: TextStyle(
                color: myColors?.secondaryColor,
                fontWeight: FontWeight.w400,
                fontFamily: 'PlusRegular',
                fontSize: 14 * scale,
              ),
            ),
          ),
          SizedBox(height: 14 * scale),
          Container(
            padding: EdgeInsets.all(5 * scale),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10 * scale),
              color: const Color(0xffEEF4F4),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: TextButton(
                    style: TextButton.styleFrom(
                      foregroundColor: selected == '8 mins'
                          ? Colors.white
                          : myColors?.primaryColor,
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      backgroundColor: selected == '8 mins'
                          ? const Color(0xFF4073C7)
                          : const Color(0xffEEF4F4),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        selected = '8 mins';
                      });
                    },
                    child: Column(children: [
                      const Text('8 mins',
                          style:
                              TextStyle(fontSize: 18, fontFamily: 'PlusBold')),
                      if (selected == '8 mins')
                        const Text('1 round',
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                fontFamily: 'PlusRegular'))
                    ]),
                  ),
                ),
                Expanded(
                  child: TextButton(
                    style: TextButton.styleFrom(
                      foregroundColor: selected == '20 mins'
                          ? Colors.white
                          : const Color(0xff1B2C56),
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      backgroundColor: selected == '20 mins'
                          ? const Color(0xFF4073C7)
                          : const Color(0xffEEF4F4),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        selected = '20 mins';
                      });
                    },
                    child: Column(children: [
                      const Text('20 mins',
                          style:
                              TextStyle(fontSize: 18, fontFamily: 'PlusBold')),
                      if (selected == '20 mins')
                        const Text('2 rounds',
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                fontFamily: 'PlusRegular'))
                    ]),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
