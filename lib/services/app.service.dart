import 'dart:convert';

import 'package:fit_worker/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class AppService {
  Future getPatient() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString('patientID') == null) {
      prefs.setString('patientID', '6537906971f461c84efbf76f');
    }
    final response = await http.get(
        Uri.parse('$api/getPatient/${prefs.getString("patientID")}'),
        headers: {
          'Content-Type': 'application/json',
        });
    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonResponse = json.decode(response.body);
      print(jsonResponse["patient"]);
      final patient = jsonResponse['patient'];
      return patient;
    } else {
      throw Exception('Failed to load patient');
    }
  }

  Future getAllDoctor() async {
    final response = await http.get(Uri.parse('$api/getalldoctor'), headers: {
      'Content-Type': 'application/json',
    });
    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonResponse = json.decode(response.body);
      print(jsonResponse["doctors"]);
      final doctors = jsonResponse['doctors'];
      return doctors;
    } else {
      throw Exception('Failed to load doctors');
    }
  }

  Future getAdvices() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final response = await http.get(
        Uri.parse('$api/getPatient/${prefs.getString("patientID")}'),
        headers: {
          'Content-Type': 'application/json',
        });
    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonResponse = json.decode(response.body);
      print(jsonResponse["advices"]);
      final advices = jsonResponse['advices'];
      return advices;
    } else {
      throw Exception('Failed to load patient');
    }
  }
}
