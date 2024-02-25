import 'package:fit_worker/views/components/checkup/check_up.dart';
import 'package:fit_worker/views/screens/exercise/congrat.screen.dart';
import 'package:fit_worker/views/screens/exercise/detail_plan.screen.dart';
import 'package:fit_worker/views/screens/exercise/hold/hold.flow.dart';
import 'package:fit_worker/views/screens/exercise/lunge/lunge.flow.dart';
import 'package:fit_worker/views/screens/exercise/squat/squat.flow.dart';
import 'package:fit_worker/views/screens/exercise/heelraise/heelraise.flow.dart';
import 'package:flutter/material.dart';

class ExerciseSessionFlow extends StatefulWidget {
  const ExerciseSessionFlow({Key? key}) : super(key: key);

  static ExerciseSessionFlowState of(BuildContext context) {
    final ExerciseSessionFlowState? result =
        context.findAncestorStateOfType<ExerciseSessionFlowState>();
    assert(result != null, 'No ExerciseSessionFlowState found in context');
    return result!;
  }

  @override
  ExerciseSessionFlowState createState() => ExerciseSessionFlowState();
}

class ExerciseSessionFlowState extends State<ExerciseSessionFlow> {
  final _navigatorKey = GlobalKey<NavigatorState>();

  static final List<Widget> _exerciseScreens = [
    squatFlow,
    holdFlow,
    const CongratScreen()
  ];

  int _currentScreenIndex = 0;

  void goToNextScreen() {
    if (_currentScreenIndex < _exerciseScreens.length - 1) {
      _navigatorKey.currentState!.pushReplacement(
        MaterialPageRoute(
            builder: (context) => _exerciseScreens[_currentScreenIndex]),
      );

      setState(() {
        _currentScreenIndex++;
      });
    } else {
      completeExerciseFlow();
    }
  }

  void quitExerciseFlow() {
    // Logic for quitting the exercise flow
    // Navigate to home screen or pop out of ExerciseFlow
    _navigatorKey.currentState!.pushReplacement(
      MaterialPageRoute(builder: (context) => const DetailPlanScreen()),
    );
  }

  void completeExerciseFlow() {
    // Logic for completing the exercise flow
    // Navigate to completion screen or pop out of ExerciseFlow
    _navigatorKey.currentState!.pushReplacement(
      MaterialPageRoute(builder: (context) => const CongratScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Navigator(
        key: _navigatorKey,
        onGenerateInitialRoutes:
            (NavigatorState navigator, String initialRoute) {
          return [
            MaterialPageRoute(
              builder: (context) => _exerciseScreens[_currentScreenIndex],
            ),
          ];
        },
      ),
    );
  }
}
