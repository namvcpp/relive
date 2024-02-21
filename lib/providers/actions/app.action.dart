import 'package:fit_worker/providers/notifiers/app.notifier.dart';
import 'package:fit_worker/services/app.service.dart';

class AppActions {
  Future<void> fetchPatient(AppNotifier notifier) async {
    try {
      final patient = await AppService().getPatient();
      notifier.setPatient(patient);
    } catch (error) {
      rethrow;
    }
  }

  Future<void> fetchDoctors(AppNotifier notifier) async {
    try {
      final doctors = await AppService().getAllDoctor();
      notifier.setDoctors(doctors);
    } catch (error) {
      rethrow;
    }
  }

  Future<void> fetchAdvices(AppNotifier notifier) async {
    try {
      final advices = await AppService().getAdvices();
      notifier.setAdvices(advices);
    } catch (error) {
      rethrow;
    }
  }

  Future<void> setPatient(AppNotifier notifier, patient) async {
    try {
      notifier.setPatient(patient);
    } catch (error) {
      rethrow;
    }
  }

  Future<void> setExercises(AppNotifier notifier) async {
    try {
      final patient = await AppService().getPatient();
      notifier.setExercises(patient["exercise"]);
    } catch (error) {
      rethrow;
    }
  }
}
