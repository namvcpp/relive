import 'package:flutter/foundation.dart';

class AppNotifier extends ChangeNotifier {
  var patient = {};
  var doctors = [];
  var advices = [];
  var exercises = [];

  void setPatient(newpatient) {
    patient = newpatient;
    notifyListeners();
  }

  void setDoctors(newdoctors) {
    doctors = newdoctors;
    notifyListeners();
  }

  void setAdvices(newadvices) {
    advices = newadvices;
    notifyListeners();
  }

  void setExercises(newexercises) {
    exercises = newexercises;
    notifyListeners();
  }
}
