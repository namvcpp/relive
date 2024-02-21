import 'package:flutter/material.dart';

class ActiveDaysGrid extends StatelessWidget {
  const ActiveDaysGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
            child: ActiveDayCard(
          title: 'Active days',
          subtitle: 'Days you’ve done at least one session',
          count: '72',
          color: Color(0xffA4D869),
        )),
        Expanded(
            child: ActiveDayCard(
          title: 'Active days in a row',
          subtitle: 'Consecutive days you’ve done at least one session',
          count: '4',
          color: Color(0xff7EA8F9),
        )),
      ],
    );
  }
}

class ActiveDayCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String count;
  final Color color;

  const ActiveDayCard({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.count,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xffEDF0F6), width: 1),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              title,
              style: const TextStyle(
                  color: Color(0xff1B2C56),
                  fontWeight: FontWeight.w900,
                  fontSize: 25.0,
                  fontFamily: "PlusBold"),
            ),
            Text(
              subtitle,
              style: const TextStyle(
                color: Color(0xff646B7B),
                fontSize: 14,
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text(
                    count,
                    style: const TextStyle(
                      color: Color(0xff1B2C56),
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
