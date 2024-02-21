import 'package:fit_worker/views/screens/exercise/exercise.flow.dart';

import 'lunge.instruction.dart';
import 'lunge.preview.dart';
import 'lunge_pose_detector.screen.dart';

var lungeFlow = const ExerciseFlow(
  screens: [
    LungeInstructionScreen(),
    LungePreviewScreen(),
    LungePoseDetectorView(),
  ],
);
