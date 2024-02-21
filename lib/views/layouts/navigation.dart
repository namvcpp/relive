// import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:fit_worker/views/screens/browse.screen.dart';
import 'package:fit_worker/views/screens/connect.screen.dart';
import 'package:fit_worker/views/screens/today.screen.dart';
import 'package:fit_worker/views/screens/progress/calendar.screen.dart';
import 'package:flutter/material.dart';
import 'package:fit_worker/config/firebase.dart';
import 'package:fit_worker/utils/icon.dart';
import 'package:fit_worker/views/app.dart';

class Navigation extends StatefulWidget {
  const Navigation({super.key, this.initialIndex = 0});

  final int initialIndex;

  @override
  NavigationState createState() => NavigationState();
}

class NavigationState extends State<Navigation> {
  int _selectedIndex = 0;
  static final List<Widget> _widgetOptions = <Widget>[
    const TodayScreen(),
    const CalendarScreen(),
    const BrowseScreen(),
    const ConnectScreen(),
  ];

  @override
  void initState() {
    super.initState();
    checkLoginAndInitFCM();
    // AwesomeNotifications().isNotificationAllowed().then((isAllowed) => {
    //       if (isAllowed)
    //         {AwesomeNotifications().requestPermissionToSendNotifications()}
    //     });

    _selectedIndex = widget.initialIndex;
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    double baseWidth = 390;
    double scale = MediaQuery.of(context).size.width / baseWidth;

    final theme = Theme.of(context);
    final myColors = theme.extension<MyColors>();

    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: Container(
        // height: 80,
        decoration: const BoxDecoration(
            border: Border(
                top: BorderSide(
          color: Color(0xFFEDF0F6),
          width: 1.5,
        ))),
        padding: EdgeInsets.only(bottom: 0 * scale, top: 6 * scale),
        child: ClipRRect(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(30 * scale),
            ),
            child: Stack(
              children: [
                BottomNavigationBar(
                  type: BottomNavigationBarType.fixed,
                  items: <BottomNavigationBarItem>[
                    BottomNavigationBarItem(
                      icon: SizedBox(
                        height: 24 * scale,
                        width: 24 * scale,
                        child:
                            _selectedIndex == 0 ? todayIconSelect : todayIcon,
                      ),
                      label: 'Today',
                    ),
                    BottomNavigationBarItem(
                      icon: SizedBox(
                        height: 24 * scale,
                        width: 24 * scale,
                        child: _selectedIndex == 1
                            ? calenderIconSelect
                            : calenderIcon,
                      ),
                      label: 'Progress',
                    ),
                    BottomNavigationBarItem(
                      icon: SizedBox(
                        height: 24 * scale,
                        width: 24 * scale,
                        child: _selectedIndex == 2 ? yogaIconSelect : yogaIcon,
                      ),
                      label: 'Browse',
                    ),
                    BottomNavigationBarItem(
                      icon: SizedBox(
                        height: 24 * scale,
                        width: 24 * scale,
                        child: _selectedIndex == 3
                            ? commentIconSelect
                            : commentIcon,
                      ),
                      label: 'Connect',
                    ),
                  ],
                  currentIndex: _selectedIndex,
                  selectedItemColor: Color(int.parse('FF1B2C56', radix: 16)),
                  unselectedItemColor: Color(int.parse('FF5B6172', radix: 16)),
                  onTap: _onItemTapped,
                ),
              ],
            )),
      ),
    );
  }
}
