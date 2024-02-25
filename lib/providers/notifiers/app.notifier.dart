import 'dart:ffi';

import 'package:flutter/foundation.dart';

class AppNotifier extends ChangeNotifier {
  int evaluation = 20;

  void setEvaluation(int value) {
    evaluation = value;
    notifyListeners();
  }
}
