import 'dart:ffi';

import 'package:fit_worker/providers/notifiers/app.notifier.dart';
import 'package:fit_worker/services/app.service.dart';

class AppActions {
  Future<void> setEvaluation(AppNotifier notifier, int evaluation) async {
    try {
      notifier.setEvaluation(evaluation);
    } catch (error) {
      rethrow;
    }
  }
}
