// import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void checkLoginAndInitFCM() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  FirebaseMessaging messaging = FirebaseMessaging.instance;
  messaging.getToken().then((String? token) {
    print("FirebaseMessaging token: $token");
  });

  FirebaseMessaging.onMessage.listen((RemoteMessage event) {
    print("message received: ${event.notification?.body}");
    print(event.notification?.body?.split("/")[0]);
    print(event.notification?.body?.split("/")[1]);
    // AwesomeNotifications().createNotification(
    //     content: NotificationContent(
    //   id: 10,
    //   channelKey: 'basic_channel',
    //   title: event.notification?.body?.split("/")[0],
    //   body: event.notification?.body?.split("/")[1],
    // ));
  });
}
