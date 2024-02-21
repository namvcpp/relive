import 'package:flutter/material.dart';
import 'package:fit_worker/utils/icon.dart';
import 'package:fit_worker/views/app.dart';

class ConnectScreen extends StatelessWidget {
  const ConnectScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // void onPressed() {
    //   Navigator.push(
    //     context,
    //     MaterialPageRoute(builder: (context) => const PoseDetectorView()),
    //   );
    // }

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
                'Connect',
                style: TextStyle(
                    color: myColors?.primaryColor,
                    fontWeight: FontWeight.w800,
                    fontSize: 18 * scale,
                    fontFamily: "PlusSemiBold"),
              ),
            ),
            SizedBox(height: 20 * scale),
            Container(
              margin: EdgeInsets.only(left: 34 * scale),
              height: 100 * scale,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.only(right: 16 * scale),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          child: Text(
                            "Chat & check up",
                            style: TextStyle(
                                color: myColors?.primaryColor,
                                fontFamily: "PlusBold",
                                fontSize: 26 * scale,
                                fontWeight: FontWeight.w800),
                          ),
                        ),
                        SizedBox(
                          height: 2 * scale,
                        ),
                        Container(
                          constraints: BoxConstraints(
                            maxWidth: 200 * scale,
                          ),
                          child: Text(
                            "Book with our top therapists to identify your problems",
                            style: TextStyle(
                              color: myColors?.secondaryColor,
                              fontFamily: "PlusRegular",
                              fontSize: 14 * scale,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 5 * scale),
                    height: 100 * scale,
                    width: 100 * scale,
                    child: Stack(
                      children: [
                        Positioned(
                          left: 10 * scale,
                          top: 0 * scale,
                          child: Align(
                            child: SizedBox(
                                child: ClipRRect(
                              borderRadius: BorderRadius.circular(180 * scale),
                              child: Image.asset("assets/images/doctor1.png"),
                            )),
                          ),
                        ),
                        Positioned(
                          left: 33 * scale,
                          top: 0,
                          child: Align(
                            child: SizedBox(
                                child: ClipRRect(
                              borderRadius: BorderRadius.circular(180 * scale),
                              child: Image.asset("assets/images/doctor1.png"),
                            )),
                          ),
                        ),
                        Positioned(
                          left: 56 * scale,
                          top: 0,
                          child: Align(
                            child: SizedBox(
                                child: ClipRRect(
                              borderRadius: BorderRadius.circular(360 * scale),
                              child: Image.asset("assets/images/doctor1.png"),
                            )),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            _buildChatCheck(context, scale, myColors),
            Container(
              margin: EdgeInsets.only(left: 34 * scale),
              child: Text(
                "Appointment",
                style: TextStyle(
                    color: myColors?.primaryColor,
                    fontFamily: "PlusBold",
                    fontSize: 26 * scale,
                    fontWeight: FontWeight.w800),
              ),
            ),
            SizedBox(
              height: 2 * scale,
            ),
            Container(
              margin: EdgeInsets.only(left: 34 * scale, right: 34 * scale),
              child: Text(
                'Book appointments at our partner clinics to identify thoroughly your problems',
                style: TextStyle(
                  color: myColors?.secondaryColor,
                  fontFamily: "PlusRegular",
                  fontSize: 14 * scale,
                ),
              ),
            ),
            SizedBox(
              height: 20 * scale,
            ),
            Container(
              margin: EdgeInsets.only(left: 34 * scale),
              height: 270 * scale,
              child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: List<Widget>.generate(
                    3,
                    (index) => Stack(
                      children: <Widget>[
                        Container(
                            width: 260 * scale,
                            height: 260 * scale,
                            padding: EdgeInsets.symmetric(horizontal: 10 * scale, vertical: 5 * scale),
                            margin: EdgeInsets.only(right: 10 * scale),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20 * scale),
                              border: Border.all(
                                color: Color(0xffbec7d8),
                                width: 1,
                              ),
                            ),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 10  * scale,
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(right: 10 * scale),
                                      width: 55 * scale,
                                      height: 55 * scale,
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(180 * scale),
                                        child: Image.asset(
                                            "assets/images/appointment.png"),
                                      ),
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          
                                          child: Text(
                                            "Physical Therapy\n@Therapist T",
                                            style: TextStyle(
                                              fontFamily: "PlusBold",
                                              fontSize: 20 * scale,
                                              fontWeight: FontWeight.w800,
                                              color: myColors?.primaryColor,
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                                SizedBox(height: 5 * scale,),
                                Container(
                                  padding: const EdgeInsets.all(10),
                                  child: RichText(
                                    text: TextSpan(
                                      children: [
                                        TextSpan(
                                          text: "Location: ",
                                          style: TextStyle(
                                            fontSize: 15 * scale,
                                            color: myColors?.primaryColor,
                                            fontWeight: FontWeight.w700,
                                            fontFamily: "PlusRegular",
                                          ),
                                        ),
                                        TextSpan(
                                          text:
                                              'S2-16, Vinhomes Oceanpark, Da Ton, Gia Lam, Hanoi \n',
                                          style: TextStyle(
                                            fontSize: 15 * scale,
                                            color: Color(0xff5b6172),
                                            fontFamily: "PlusRegular",
                                          ),
                                        ),
                                        TextSpan(
                                          text: 'Rating ',
                                          style: TextStyle(
                                            fontSize: 15 * scale,
                                            color: myColors?.primaryColor,
                                            fontWeight: FontWeight.w700,
                                            fontFamily: "PlusRegular",
                                          ),
                                        ),
                                        TextSpan(
                                          text: '4.92/5 *',
                                          style: TextStyle(
                                            fontSize: 15 * scale,
                                            color: myColors?.primaryColor,
                                            fontFamily: "PlusRegular",
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                    alignment: Alignment.center,
                                    child: Container(
                                      // margin: const EdgeInsets.only(
                                      //     left: 16, right: 16),
                                      padding: EdgeInsets.only(left: 10 * scale),
                                      child: Row(
                                        children: [
                                          RichText(
                                              text: TextSpan(
                                            children: [
                                              TextSpan(
                                                text: "Opening hours: \n",
                                                style: TextStyle(
                                                  fontSize: 15 * scale,
                                                  color: myColors?.primaryColor,
                                                  fontWeight: FontWeight.w700,
                                                  fontFamily: "PlusRegular",
                                                ),
                                              ),
                                              TextSpan(
                                                text: ' 8:00 - 21:00 \n',
                                                style: TextStyle(
                                                  fontSize: 15 * scale,
                                                  color: myColors?.secondaryColor,
                                                  fontFamily: "PlusRegular",
                                                ),
                                              ),
                                            ],
                                          )),
                                          SizedBox(width: 5 * scale),
                                          TextButton(
                                            style: TextButton.styleFrom(
                                                backgroundColor:
                                                    myColors?.primaryColor ??
                                                        Colors.black,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(10 * scale),
                                                ),
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 20 * scale,
                                                    vertical: 15 * scale)),
                                            onPressed: () {},
                                            child: Row(
                                              children: [
                                                Text(
                                                  'Book',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 16 * scale,
                                                      fontWeight: FontWeight.w700,
                                                      fontFamily: 'PlusSemiBold'),
                                                ),
                                                SizedBox(width: 5 * scale),
                                                Icon(
                                                  Icons.arrow_forward_outlined,
                                                  color: Colors.white,
                                                  size: 17 * scale,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ))
                              ],
                            )),
                      ],
                    ),
                  )),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChatCheck(
      BuildContext context, double scale, MyColors? myColors) {
    return Container(
      margin: EdgeInsets.only(left: 34 * scale),
      height: 350 * scale,
      child: ListView(
          scrollDirection: Axis.horizontal,
          children: List<Widget>.generate(
            3,
            (index) => Stack(
              children: <Widget>[
                Container(
                    width: 250 * scale,
                    height: 320 * scale,
                    margin: EdgeInsets.only(right: 10 * scale),
                    padding: EdgeInsets.symmetric(
                        horizontal: 10 * scale, vertical: 5 * scale),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: const Color(0xffbec7d8),
                        width: 1,
                      ),
                    ),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 10 * scale,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsets.only(right: 10 * scale),
                              width: 55 * scale,
                              height: 55 * scale,
                              child: ClipRRect(
                                borderRadius:
                                    BorderRadius.circular(180 * scale),
                                child: Image.asset("assets/images/doctor1.png"),
                              ),
                            ),
                            Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    child: Text(
                                      "Dr.Tung Nguyen",
                                      style: TextStyle(
                                        fontFamily: "PlusBold",
                                        fontSize: 20 * scale,
                                        fontWeight: FontWeight.w800,
                                        color: myColors?.primaryColor,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    child: Text(
                                      "Physical Therapist",
                                      style: TextStyle(
                                        fontFamily: "PlusSemiBold",
                                        fontSize: 12 * scale,
                                        color: myColors?.secondaryColor,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    child: Text(
                                      "@Therapist T",
                                      style: TextStyle(
                                        fontFamily: "PlusSemiBold",
                                        fontSize: 12 * scale,
                                        color: myColors?.secondaryColor,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                        Container(
                          padding: EdgeInsets.all(10 * scale),
                          child: RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: "Introduction: \n",
                                  style: TextStyle(
                                    fontSize: 14 * scale,
                                    color: myColors?.primaryColor,
                                    fontWeight: FontWeight.w700,
                                    fontFamily: "PlusSemiBold",
                                  ),
                                ),
                                WidgetSpan(
                                  child: SizedBox(
                                      height: 10 *
                                          scale), // Tạo khoảng cách bằng một SizedBox
                                ),
                                TextSpan(
                                  text:
                                      'Hello, I am Tung, 10+ years experience into the industry, and my clients all have reduced their pain above 60% through my diagnosis and supervision\n',
                                  style: TextStyle(
                                    fontSize: 14 * scale,
                                    color: myColors?.secondaryColor,
                                    fontFamily: "PlusRegular",
                                  ),
                                ),
                                WidgetSpan(
                                  child: SizedBox(
                                      height: 10 *
                                          scale), // Tạo khoảng cách bằng một SizedBox
                                ),
                                TextSpan(
                                  text: '\nRating: ',
                                  style: TextStyle(
                                    fontSize: 14 * scale,
                                    color: myColors?.primaryColor,
                                    fontWeight: FontWeight.w700,
                                    fontFamily: "PlusSemiBold",
                                  ),
                                ),
                                TextSpan(
                                  text: '4.92/5 *',
                                  style: TextStyle(
                                    fontSize: 14 * scale,
                                    color: myColors?.secondaryColor,
                                    fontFamily: "PlusRegular",
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 5 * scale,
                        ),
                        Align(
                            alignment: Alignment.center,
                            child: Container(
                              margin: EdgeInsets.only(left: 10 * scale),
                              child: Row(
                                children: [
                                  TextButton(
                                    style: TextButton.styleFrom(
                                        backgroundColor: Colors.white,
                                        side: BorderSide(
                                            color: myColors?.primaryColor ??
                                                Colors.black,
                                            width: 1.5),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10 * scale),
                                        ),
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 30 * scale,
                                            vertical: 15 * scale)),
                                    onPressed: () {},
                                    child: Text(
                                      'Chat',
                                      style: TextStyle(
                                          color: myColors?.primaryColor,
                                          fontSize: 16 * scale,
                                          fontWeight: FontWeight.w800,
                                          fontFamily: 'PlusSemiBold'),
                                    ),
                                  ),
                                  SizedBox(width: 5 * scale),
                                  TextButton(
                                    style: TextButton.styleFrom(
                                        backgroundColor:
                                            myColors?.primaryColor ??
                                                Colors.black,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10 * scale),
                                        ),
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 25 * scale,
                                            vertical: 15 * scale)),
                                    onPressed: () {},
                                    child: Row(
                                      children: [
                                        Text(
                                          'Book',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16 * scale,
                                              fontWeight: FontWeight.w800,
                                              fontFamily: 'PlusSemiBold'),
                                        ),
                                        SizedBox(width: 5 * scale),
                                        Icon(
                                          Icons.arrow_forward_outlined,
                                          color: Colors.white,
                                          size: 17 * scale,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ))
                      ],
                    )),
              ],
            ),
          )),
    );
  }
}
