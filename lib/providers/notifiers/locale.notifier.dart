import 'package:fit_worker/l10n/l10n.dart';
import 'package:flutter/material.dart';

class LocalesNotifier extends ChangeNotifier {
  String languageCode = 'en';
  Locale _locale = Locale('en');
  int evaluation = 60;

  Locale get locale => _locale;

  void setLocale(Locale locale) {
    _locale = locale;
    notifyListeners();
  }

  void setEvaluation(int value) {
    evaluation = value;
    notifyListeners();
  }
}
