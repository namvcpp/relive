import 'package:fit_worker/views/screens/exercise/detail_plan.screen.dart';
import 'package:fit_worker/views/screens/learn/information.dart';
import 'package:fit_worker/views/app.dart';
import 'package:flutter/material.dart';
import 'package:dotted_line/dotted_line.dart';

class PlanCard extends StatelessWidget {
  final planCard;
  final bool? isLast;
  const PlanCard({Key? key, this.planCard, this.isLast}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double baseWidth = 390;
    double scale = MediaQuery.of(context).size.width / baseWidth;

    final theme = Theme.of(context);
    final myColors = theme.extension<MyColors>();
    
    return Row(
      children: [
        SizedBox(width: 10),
        Column(
          children: [
            planCard["Text1"] == "Learn"
                ? const DottedLine(
                    direction: Axis.vertical,
                    lineThickness: 3,
                    dashColor: Colors.white,
                    lineLength: 60,
                    dashLength: 11,
                  )
                : const DottedLine(
                    direction: Axis.vertical,
                    lineThickness: 3,
                    dashColor: Color(0xFFBDC9E5),
                    lineLength: 60,
                    dashLength: 11,
                  ),

            Icon(
              planCard["isSelected"]
                  ? Icons.check_circle
                  : Icons.circle_outlined,
              size: 30,
            ),
            const DottedLine(
                direction: Axis.vertical,
                lineThickness: 3,
                dashColor: Color(0xFFBDC9E5),
                lineLength: 60,
                dashLength: 11,
              ),
          ],
        ),
        Expanded(
          child: InkWell(
            onTap: () {
              if (planCard["isSelected"] && planCard["Text1"] == "Learn") {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const LearnInformationScreen()));
              } else if (planCard["isSelected"] &&
                  planCard["Text1"] == "Exercise") {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const DetailPlanScreen()));
              }
            },
            child: Container(
              margin: EdgeInsets.only(left: 5 * scale, right: 15 * scale),
              child: Stack(
                children: [
                  Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Container(
                              alignment: Alignment.centerLeft,
                              height: 134 * scale,
                              padding: EdgeInsets.symmetric(horizontal: 20 * scale),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(25 * scale),),
                                color: Color(planCard["bgColor"]),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        flex: 4,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                                width: 200 * scale,
                                                child: Text(
                                                  planCard["title"],
                                                  style: TextStyle(
                                                      fontSize: 18 * scale,
                                                      fontWeight: FontWeight.w700,
                                                      color: myColors?.primaryColor,
                                                      fontFamily: 'PlusBold'),
                                                )),
                                            SizedBox(height: 4 * scale),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                planCard["Icon1"],
                                                SizedBox(width: 4 * scale),
                                                Text(
                                                  planCard["Text1"],
                                                  style: TextStyle(
                                                      color: myColors?.primaryColor,
                                                      fontFamily: 'PlusSemiBold'),
                                                ),
                                                SizedBox(width: 14 * scale),
                                                planCard["Icon2"],
                                                SizedBox(width: 4 * scale),
                                                Text(
                                                  planCard["Text2"],
                                                  style: TextStyle(
                                                      color: myColors?.primaryColor,
                                                      fontFamily: 'PlusSemiBold'),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      const Expanded(
                                        flex: 1,
                                        child: Text(""),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Positioned(
                    right: 18,
                    bottom: 0,
                    child: planCard["Layer"],
                  ),
                ],
              ),
            ),
          )
        ),
      ],
    );
  }
}
