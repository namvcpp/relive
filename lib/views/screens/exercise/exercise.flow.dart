import 'package:fit_worker/views/screens/exercise/session.flow.dart';
import 'package:flutter/material.dart';

class ExerciseFlow extends StatefulWidget {
  const ExerciseFlow({Key? key, required this.screens}) : super(key: key);

  final List<Widget> screens;

  static ExerciseFlowState of(BuildContext context) {
    final ExerciseFlowState? result =
        context.findAncestorStateOfType<ExerciseFlowState>();
    assert(result != null, 'No ExerciseFlowState found in context');
    return result!;
  }

  @override
  ExerciseFlowState createState() => ExerciseFlowState();
}

class ExerciseFlowState extends State<ExerciseFlow> {
  int _currentScreenIndex = 0;

  void goToPreviousScreen() {
    if (_currentScreenIndex <= 0) {
      // Same as swiping back
      ExerciseSessionFlow.of(context).quitExerciseFlow();
    }

    setState(() {
      if (_currentScreenIndex > 0) _currentScreenIndex--;
    });
  }

  void goToNextScreen() {
    if (_currentScreenIndex >= widget.screens.length - 1) {
      completeExerciseFlow();
    }

    setState(() {
      _currentScreenIndex++;
    });
  }

  void completeExerciseFlow() {
    ExerciseSessionFlow.of(context).goToNextScreen();
  }

  @override
  Widget build(BuildContext context) {
    final currentScreen = widget.screens[_currentScreenIndex];

    return Scaffold(
      body: currentScreen,
    );
  }
}
