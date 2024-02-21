import 'package:fit_worker/views/layouts/navigation.dart';
import 'package:flutter/material.dart';

class CongratScreen extends StatelessWidget {
  const CongratScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 300,
          flexibleSpace: SizedBox(
              width: 700,
              height: 350,
              child: Stack(
                children: [
                  Positioned(
                    top: 0,
                    right: 0,
                    child: Image.asset('assets/images/congrat1.png'),
                  ),
                  Positioned(
                    // left: 0,
                    // right: 0,
                    top: -20,
                    child: Image.asset('assets/images/congrat2.png'),
                  ),
                  Positioned(
                    left: 0,
                    right: 0,
                    top: 0,
                    bottom: 0,
                    child: Image.asset('assets/images/congrat3.png'),
                  ),
                  Positioned(
                    left: 0,
                    right: 0,
                    top: 0,
                    bottom: 0,
                    child: Image.asset('assets/images/congrat4.png'),
                  ),
                  Positioned(
                    top: 0,
                    left: 0,
                    child: Image.asset('assets/images/congrat.png'),
                  ),
                ],
              )),
          leading: null,
          automaticallyImplyLeading: false,
          actions: <Widget>[Container()],
        ),
        body: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Congratulations! You have finished your exercises.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                '   “Exercises is king and nutrition is queen.       Combine the two and you will have a kingdom.”',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 15),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                '-Jack Lalanne',
                style: TextStyle(fontSize: 15),
              ),
              const SizedBox(
                height: 100,
              ),
              Center(
                child: ElevatedButton(
                  style: ButtonStyle(
                      minimumSize:
                          MaterialStateProperty.all(const Size(300, 60)),
                      alignment: Alignment.center,
                      backgroundColor:
                          MaterialStateProperty.all(const Color(0xFF1B2C56))),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Navigation(
                          initialIndex: 1,
                        ),
                      ),
                    );
                  },
                  child: const Text(
                    'See Progress',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontFamily: 'PlusBold'),
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
