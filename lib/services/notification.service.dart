import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class NotificationService {
  Future<void> sendNotification(body) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    if (prefs.getString("userId") == null) {
      prefs.setString("userId", "64ea5334773559ab41794a0f");
    }
    print(body["hour"].toString());
    print(body["minute"].toString());
    messaging.getToken().then((String? token) {
      return http.post(Uri.parse("http://10.1.4.173:3000/api/notification"),
          body: jsonEncode({
            "userId": prefs.getString("userId"),
            "title": "Tập thể dục",
            "content": "Đã đến giờ tập thể dục rồi nhé!",
            // "start": DateTime.now().toString().split(" ")[0],
            "hour": body["hour"].toString(),
            "minute": body["minute"].toString(),
            "deviceToken": token,
          }),
          headers: {"Content-Type": "application/json"});
    }).then((response) => {
          print(response.body),
          if (response.statusCode == 200)
            {print("Success")}
          else
            {print("Fail")}
        });
  }
}
