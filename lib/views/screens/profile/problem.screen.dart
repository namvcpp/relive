import 'package:fit_worker/utils/icon.dart';
import 'package:fit_worker/utils/image.dart';
import 'package:flutter/material.dart';

class ProblemScreen extends StatefulWidget {
  const ProblemScreen({Key? key}) : super(key: key);
  @override
  _ProblemScreenState createState() => _ProblemScreenState();
}

class _ProblemScreenState extends State<ProblemScreen> {
  final listImg = [
    pill1Img,
    pill2Img,
  ];
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: Align(
            alignment: Alignment.topLeft,
            child: IconButton(
              icon: backIcon,
              onPressed: () => Navigator.pop(context),
            ),
          ),
          title: Text(
            "Your MSK Problems",
            style: TextStyle(
                color: Color(0xff1B2C56),
                fontWeight: FontWeight.w800,
                fontSize: 15,
                fontFamily: 'PlusSemiBold'),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding:
                    EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Color(0xFFB9E9FD), // Sử dụng màu nền #B9E9FD
                ),
                child: Text("Upper Body"),
              ),
              Container(
                padding:
                    EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
                width: double.infinity,
                // decoration: BoxDecoration(
                //   color: Color(0xFFB9E9FD), // Sử dụng màu nền #B9E9FD
                // ),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                            left: 20, right: 20, top: 10, bottom: 10),
                        child: Text(
                          "1. Shoulder",
                          style: TextStyle(
                            fontFamily: "PlusSemiBold",
                            fontSize: 20,
                            color: Color(0xFF1B2C56),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 20, right: 20),
                        child: RichText(
                            text: TextSpan(
                                style: TextStyle(
                                  fontFamily: "PlusRegular",
                                  fontSize: 15,
                                  color: Color(0xFF1B2C56),
                                ),
                                children: [
                              TextSpan(
                                text: "Level of Pain: ",
                                style: TextStyle(
                                  fontFamily: "PlusSemiBold",
                                  fontSize: 15,
                                  color: Color(0xFF1B2C56),
                                ),
                              ),
                              TextSpan(
                                text: "Moderate",
                                style: TextStyle(
                                  fontFamily: "PlusRegular",
                                  fontSize: 15,
                                  color: Color(0xFF1B2C56),
                                ),
                              ),
                            ])),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                            left: 20, right: 20, top: 10, bottom: 10),
                        child: RichText(
                            text: TextSpan(
                                style: TextStyle(
                                  fontFamily: "PlusRegular",
                                  fontSize: 15,
                                  color: Color(0xFF1B2C56),
                                ),
                                children: [
                              TextSpan(
                                text: "Doctor notes: ",
                                style: TextStyle(
                                  fontFamily: "PlusSemiBold",
                                  fontSize: 15,
                                  color: Color(0xFF1B2C56),
                                ),
                              ),
                              TextSpan(
                                text:
                                    ' \nMajor disruption in the bones under the shoulder, needs daily rest\nPatient needs to practice at least 5 sessions/week, with timely short sessions to alleviate the pain',
                                style: TextStyle(
                                  fontFamily: "PlusRegular",
                                  fontSize: 15,
                                  color: Color(0xFF1B2C56),
                                ),
                              ),
                            ])),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 20, right: 20),
                        child: Text(
                          'Prescription:',
                          style: TextStyle(
                            fontFamily: "PlusSemiBold",
                            fontSize: 15,
                            color: Color(0xFF1B2C56),
                          ),
                        ),
                      ),
                      Container(
                        margin:
                            EdgeInsets.only(left: 20, right: 20, bottom: 20),
                        child: SizedBox(
                          height: 145,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: 2,
                            itemBuilder: (context, index) {
                              return Padding(
                                  padding: const EdgeInsets.only(top: 10),
                                  child: listImg[index]);
                            },
                          ),
                        ),
                      )
                    ]),
              ),
              Container(
                padding:
                    EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Color(0xFFB9E9FD), // Sử dụng màu nền #B9E9FD
                ),
                child: Text("Lower Body"),
              ),
              Container(
                padding:
                    EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
                width: double.infinity,
                // decoration: BoxDecoration(
                //   color: Color(0xFFB9E9FD), // Sử dụng màu nền #B9E9FD
                // ),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                            left: 20, right: 20, top: 10, bottom: 10),
                        child: Text(
                          "1. Knee",
                          style: TextStyle(
                            fontFamily: "PlusSemiBold",
                            fontSize: 20,
                            color: Color(0xFF1B2C56),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 20, right: 20),
                        child: RichText(
                            text: TextSpan(
                                style: TextStyle(
                                  fontFamily: "PlusRegular",
                                  fontSize: 15,
                                  color: Color(0xFF1B2C56),
                                ),
                                children: [
                              TextSpan(
                                text: "Level of Pain: ",
                                style: TextStyle(
                                  fontFamily: "PlusSemiBold",
                                  fontSize: 15,
                                  color: Color(0xFF1B2C56),
                                ),
                              ),
                              TextSpan(
                                text: "Moderate",
                                style: TextStyle(
                                  fontFamily: "PlusRegular",
                                  fontSize: 15,
                                  color: Color(0xFF1B2C56),
                                ),
                              ),
                            ])),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                            left: 20, right: 20, top: 10, bottom: 10),
                        child: RichText(
                            text: TextSpan(
                                style: TextStyle(
                                  fontFamily: "PlusRegular",
                                  fontSize: 15,
                                  color: Color(0xFF1B2C56),
                                ),
                                children: [
                              TextSpan(
                                text: "Doctor notes: ",
                                style: TextStyle(
                                  fontFamily: "PlusSemiBold",
                                  fontSize: 15,
                                  color: Color(0xFF1B2C56),
                                ),
                              ),
                              TextSpan(
                                text:
                                    ' \nMajor disruption in the bones under the shoulder, needs daily rest\nPatient needs to practice at least 5 sessions/week, with timely short sessions to alleviate the pain',
                                style: TextStyle(
                                  fontFamily: "PlusRegular",
                                  fontSize: 15,
                                  color: Color(0xFF1B2C56),
                                ),
                              ),
                            ])),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 20, right: 20),
                        child: Text(
                          'Prescription:',
                          style: TextStyle(
                            fontFamily: "PlusSemiBold",
                            fontSize: 15,
                            color: Color(0xFF1B2C56),
                          ),
                        ),
                      ),
                      Container(
                        margin:
                            EdgeInsets.only(left: 20, right: 20, bottom: 20),
                        child: SizedBox(
                          height: 145,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: 2,
                            itemBuilder: (context, index) {
                              return Padding(
                                  padding: const EdgeInsets.only(top: 10),
                                  child: listImg[index]);
                            },
                          ),
                        ),
                      )
                    ]),
              ),
            ],
          ),
        ));
  }
}
