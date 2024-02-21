import 'package:fit_worker/providers/actions/app.action.dart';
import 'package:fit_worker/providers/notifiers/app.notifier.dart';
import 'package:fit_worker/views/screens/profile/problem.screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:fit_worker/views/app.dart';
import 'package:fit_worker/utils/icon.dart';

class ProfileScreeen extends StatefulWidget {
  const ProfileScreeen({Key? key}) : super(key: key);

  @override
  _ProfileScreeenState createState() => _ProfileScreeenState();
}

class _ProfileScreeenState extends State<ProfileScreeen> {
  String formatDOB(String dob) {
    final inputFormat = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'");
    final outputFormat = DateFormat("dd/MM/yyyy");
    final parsedDate = inputFormat.parse(dob);
    final formattedDate = outputFormat.format(parsedDate);

    return formattedDate;
  }

  @override
  void initState() {
    super.initState();
    // AppActions().fetchPatient(context.read<AppNotifier>());
  }

  @override
  Widget build(BuildContext context) {
    // return Consumer<AppNotifier>(builder: (context, notifier, _) {

    double baseWidth = 390;
    double scale = MediaQuery.of(context).size.width / baseWidth;

    final theme = Theme.of(context);
    final myColors = theme.extension<MyColors>();

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(top: 30 * scale),
          height: MediaQuery.of(context).size.height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: baseWidth * scale,
                child: Stack(
                  children: [
                    Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.all(20 * scale),
                      child: Text(
                        'User Profile',
                        style: TextStyle(
                          color: myColors?.primaryColor,
                          fontWeight: FontWeight.w800,
                          fontSize: 18 * scale,
                          fontFamily: "PlusSemiBold",
                        ),
                      ),
                    ),
                    Positioned(
                      top: 10 * scale,
                      left: 10 * scale,
                      child: IconButton(
                        icon: closeIcon,
                        onPressed: () => Navigator.pop(context),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 20 * scale,
                      ),
                      _buildFirstCard(context, scale, myColors),
                      SizedBox(
                        height: 20 * scale,
                      ),
                      Divider(
                        color: const Color(0xffbec7d8),
                        thickness: 1,
                      ),
                      SizedBox(
                        height: 20 * scale,
                      ),
                      _buildNotiCard(context, scale, myColors),
                      SizedBox(
                        height: 20 * scale,
                      ),
                    ]),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFirstCard(
      BuildContext context, double scale, MyColors? myColors) {
    return Container(
      height: 300 * scale,
      margin: EdgeInsets.symmetric(horizontal: 28 * scale),
      child: Stack(
        children: [
          Positioned(
              left: 0,
              top: 40 * scale,
              child: Container(
                padding: EdgeInsets.all(20 * scale),
                margin: EdgeInsets.only(right: 20 * scale),
                height: 250 * scale,
                width: 330 * scale,
                decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xffbec7d8)),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(right: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 40 * scale,
                          ),
                          Container(
                            alignment: Alignment.center,
                            child: Text(
                              "Mr. Nguyen Thanh Tung",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: "PlusSemiBold",
                                fontSize: 18 * scale,
                                color: myColors?.primaryColor,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20 * scale,
                          ),
                          Container(
                            child: RichText(
                                text: TextSpan(
                                    style: TextStyle(
                                      fontFamily: "PlusRegular",
                                      fontSize: 14 * scale,
                                      color: myColors?.primaryColor,
                                    ),
                                    children: [
                                  TextSpan(
                                      text: "D.O.B:  ",
                                      style: TextStyle(
                                          color: myColors?.primaryColor,
                                          fontWeight: FontWeight.w700)),
                                  TextSpan(text: "16/11/2002"),
                                ])),
                          ),
                          SizedBox(
                            height: 5 * scale,
                          ),
                          Container(
                            child: RichText(
                                text: TextSpan(
                                    style: TextStyle(
                                      fontFamily: "PlusRegular",
                                      fontSize: 14 * scale,
                                      color: myColors?.primaryColor,
                                    ),
                                    children: [
                                  TextSpan(
                                      text: "Mobile:  ",
                                      style: TextStyle(
                                          color: myColors?.primaryColor,
                                          fontWeight: FontWeight.w700)),
                                  TextSpan(text: "(+84)982989417"),
                                ])),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Container(
                            child: RichText(
                                text: TextSpan(
                                    style: TextStyle(
                                      fontFamily: "PlusRegular",
                                      fontSize: 14 * scale,
                                      color: myColors?.primaryColor,
                                    ),
                                    children: [
                                  TextSpan(
                                      text: "Email:  ",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w700)),
                                  TextSpan(text: "tungrok7@gmail.com"),
                                ])),
                          ),
                          SizedBox(
                            height: 5 * scale,
                          ),
                          Container(
                            child: RichText(
                                text: TextSpan(
                                    style: TextStyle(
                                      fontFamily: "PlusRegular",
                                      fontSize: 14 * scale,
                                      color: myColors?.primaryColor,
                                    ),
                                    children: [
                                  TextSpan(
                                      text: "Address:  ",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w700)),
                                  TextSpan(
                                      text:
                                          "Ngo 23 Phan Van Truong, Cau Giay, Ha Noi, 10 000"),
                                ])),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              )),
          Positioned(
            left: 120 * scale,
            top: 0,
            child: Align(
              child: SizedBox(
                width: 90 * scale,
                height: 90 * scale,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(180 * scale),
                  child: Image.asset(
                    "assets/images/patient.png",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNotiCard(
      BuildContext context, double scale, MyColors? myColors) {
    return Container(
        padding: EdgeInsets.all(24 * scale),
        margin: EdgeInsets.symmetric(horizontal: 28 * scale),
        height: 200 * scale,
        width: 330 * scale,
        decoration: BoxDecoration(
          border: Border.all(color: const Color(0xffbec7d8)),
          borderRadius: BorderRadius.circular(20 * scale),
        ),
        child: Stack(
          children: [
            Positioned(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(right: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 10 * scale,
                        ),
                        Container(
                          child: Text(
                            'Your MSK Problems',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.w800,
                              color: myColors?.primaryColor,
                              fontFamily: "PlusSemiBold",
                              fontSize: 18 * scale,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10 * scale,
                        ),
                        Container(
                          child: RichText(
                              text: TextSpan(
                                  style: TextStyle(
                                    fontFamily: "PlusRegular",
                                    fontSize: 14 * scale,
                                    color: Color(0xff5b6172),
                                  ),
                                  children: [
                                TextSpan(
                                  style: TextStyle(
                                    fontFamily: "PlusRegular",
                                    fontSize: 14 * scale,
                                    color: myColors?.primaryColor,
                                  ),
                                  text:
                                      'View your up-to-date state of problems or diagnosis from doctor',
                                ),
                              ])),
                        ),
                        SizedBox(
                          height: 25 * scale,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Positioned(
              right: 0,
              bottom: 0,
              child: ElevatedButton(
                  style: ButtonStyle(
                      minimumSize:
                          MaterialStateProperty.all(const Size(100, 55)),
                      maximumSize:
                          MaterialStateProperty.all(const Size(140, 85)),
                      alignment: Alignment.center,
                      backgroundColor:
                          MaterialStateProperty.all(myColors?.primaryColor)),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ProblemScreen()),
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'View',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16 * scale,
                            fontFamily: 'PlusSemiBold'),
                      ),
                      SizedBox(
                        width: 5 * scale,
                      ),
                      Icon(
                        Icons.arrow_forward_outlined,
                        color: Colors.white,
                        size: 18 * scale,
                      ),
                    ],
                  )),
            ),
            Positioned(
              top: 0,
              right: 0,
              child: Container(
                width: 50 *
                    scale, // Điều chỉnh kích thước container theo nhu cầu của bạn
                height: 50 * scale,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.red,
                ),
                child: Center(
                  child: Text(
                    '2',
                    style: TextStyle(
                      color: Colors.white, // Màu chữ số 2
                      fontSize: 24 * scale, // Kích thước chữ số 2
                    ),
                  ),
                ),
              ),
            )
          ],
        ));
  }
}
