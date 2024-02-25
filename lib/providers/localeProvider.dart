import 'package:fit_worker/l10n/l10n.dart';
import 'package:flutter/material.dart';

class LocaleProvider extends ChangeNotifier {
  String languageCode = 'en';
  Locale _locale = Locale('en');

  Locale get locale => _locale;

  void setLocale(Locale locale) {
    if (L10n.all.contains(locale)) return;

    _locale = locale;
    notifyListeners();
  }
}
