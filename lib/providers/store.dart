import 'package:fit_worker/providers/notifiers/app.notifier.dart';
import 'package:fit_worker/providers/notifiers/locale.notifier.dart';
import 'package:fit_worker/providers/notifiers/plan.notifier.dart';

class Store {
  final PlanNotifier planNotifier;
  final LocalesNotifier localesNotifier;
  final AppNotifier appNotifier;

  Store()
      : planNotifier = PlanNotifier(),
        localesNotifier = LocalesNotifier(),
        appNotifier = AppNotifier();
}
