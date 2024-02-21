import 'package:fit_worker/views/components/progress/activity.card.dart';
import 'package:fit_worker/views/components/progress/chart.card.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:fit_worker/views/app.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({Key? key}) : super(key: key);

  @override
  State<CalendarScreen> createState() => CalendarScreenState();
}

class CalendarScreenState extends State<CalendarScreen> {
  
  CalendarFormat _format = CalendarFormat.month;
  DateTime _focusedDay = DateTime(
    DateTime.now().year,
    DateTime.now().month + 1,
    0,
  );
  List<DateTime> _selectedDays = [];

  @override
  void initState() {
    super.initState();
    setState(() {
      _selectedDays.add(DateTime.now());
    });
  }

  // @override
  // bool debugAssertIsValid() {
  //   assert(shape != BoxShape.circle ||
  //       borderRadius == null); // Can't have a border radius if you're a circle.
  //   return super.debugAssertIsValid();
  // }
  // assert(myDecoration.debugAssertIsValid());

  TextStyle commonTextStyle = const TextStyle(
    color: Color(0xff646B7B),
    fontSize: 20,
    fontFamily: "PlusBold",
    fontWeight: FontWeight.w700,
  );


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
                    'Progress',
                    style: TextStyle(
                        color: myColors?.primaryColor,
                        fontWeight: FontWeight.w800,
                        fontSize: 18 * scale,
                        fontFamily: "PlusSemiBold"),
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  margin:
                      EdgeInsets.symmetric(vertical: 20 * scale, horizontal: 20 * scale),
                  padding: EdgeInsets.only(left: 16 * scale, right: 16 * scale),
                  child: Text(
                    'Activity',
                    style: TextStyle(
                        color: myColors?.primaryColor,
                        fontWeight: FontWeight.w800,
                        fontSize: 24 * scale,
                        fontFamily: "PlusSemiBold"),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 20 * scale, right: 20 * scale),
                child: tableCalendar(),
              ),
              SizedBox(height: 20 * scale),
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  margin:
                      EdgeInsets.symmetric(vertical: 20 * scale, horizontal: 20 * scale),
                  padding: EdgeInsets.only(left: 16 * scale, right: 16 * scale),
                  child: Text(
                    'Pain progress',
                    style: TextStyle(
                        color: myColors?.primaryColor,
                        fontWeight: FontWeight.w800,
                        fontSize: 24 * scale,
                        fontFamily: "PlusSemiBold"),
                  ),
                ),
              ),
              Container(
                  margin: EdgeInsets.only(top: 10 * scale, bottom: 20 * scale, left: 20 * scale),
                  // child: const ActiveDaysGrid(),
                  child: const LineChartSample2())
            ],
          ),
        ));
  }

  Widget tableCalendar() {
    return TableCalendar(
      selectedDayPredicate: (day) {
        return _selectedDays.contains(day);
      },
      focusedDay: _focusedDay,
      firstDay: DateTime(DateTime.now().year - 1, 1, 1),
      lastDay: _focusedDay,
      calendarFormat: _format,
      rowHeight: 48,
      availableCalendarFormats: const {
        CalendarFormat.month: 'Month',
      },
      headerStyle: const HeaderStyle(
        titleCentered: true,
        formatButtonVisible: false,
        titleTextStyle: TextStyle(
          fontSize: 24,
          color: Color(0xff1B2C56),
          fontWeight: FontWeight.bold,
          fontFamily: "PlusBold",
        ),
      ),
      calendarStyle: CalendarStyle(
        defaultDecoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
          shape: BoxShape.rectangle,
        ),
        defaultTextStyle: TextStyle(
          fontSize: 20,
          color: Color(0xff1B2C56),
          fontWeight: FontWeight.bold,
          fontFamily: "PlusSemiBold",
        ),
        weekendTextStyle: TextStyle(
          fontSize: 20,
          color: Color(0xff1B2C56),
          fontWeight: FontWeight.bold,
          fontFamily: "PlusSemiBold",
        ),
        holidayTextStyle: commonTextStyle,
        outsideTextStyle: commonTextStyle,
        withinRangeTextStyle: commonTextStyle,
        disabledTextStyle: commonTextStyle,
        outsideDaysVisible: false,
        todayDecoration: const BoxDecoration(
          color: Color(0xffA4D869),
          borderRadius: BorderRadius.all(Radius.circular(10)),
          shape: BoxShape.rectangle,
        ),
        todayTextStyle: commonTextStyle,
        selectedDecoration: const BoxDecoration(
            color: Color(0xffA4D869),
            borderRadius: BorderRadius.all(Radius.circular(10)),
            shape: BoxShape.rectangle),
        selectedTextStyle: TextStyle(
          fontSize: 20,
          color: Color(0xff1B2C56),
          fontWeight: FontWeight.bold,
          fontFamily: "PlusBold",
        ),
      ),
      daysOfWeekStyle: DaysOfWeekStyle(
        weekdayStyle: commonTextStyle.copyWith(fontSize: 13),
        weekendStyle: commonTextStyle.copyWith(fontSize: 13),
      ),
      onPageChanged: (focusedDay) {
        _focusedDay = focusedDay;
      },
      onDaySelected: (selectedDay, focusedDay) {
        print(selectedDay);
        print(focusedDay);
        if (_selectedDays.contains(selectedDay)) {
          _selectedDays.remove(selectedDay);
        } else {
          _selectedDays.add(selectedDay);
        }
        setState(() {
          _selectedDays = _selectedDays;
        });
      },
    );
  }
}
