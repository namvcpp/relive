import 'package:fit_worker/providers/notifiers/app.notifier.dart';
import 'package:fit_worker/providers/notifiers/locale.notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';

class LocaleAction {
  Future<void> setLocale(LocalesNotifier notifier, String languageCode) async {
    try {
      notifier.setLocale(Locale(languageCode));
    } catch (error) {
      rethrow;
    }
  }

  Future<void> setEvaluation(AppNotifier notifier, int evaluation) async {
    try {
      notifier.setEvaluation(evaluation);
    } catch (error) {
      rethrow;
    }
  }
}
