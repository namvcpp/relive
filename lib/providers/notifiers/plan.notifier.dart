import 'package:flutter/foundation.dart';

class PlanNotifier extends ChangeNotifier {
  List plans = [];

  void setPlans(newPlans) {
    plans = newPlans;
    notifyListeners();
  }
}
