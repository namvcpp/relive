// import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fit_worker/views/app.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  // AwesomeNotifications().initialize(
  //     null,
  //     [
  //       NotificationChannel(
  //           channelKey: 'basic_channel',
  //           channelName: 'Basic notifications',
  //           channelDescription: 'Notification channel for basic tests',
  //           defaultColor: Color(0xFF9D50DD),
  //           ledColor: Colors.white)
  //     ],
  //     debug: true);
  runApp(MyApp());
}
