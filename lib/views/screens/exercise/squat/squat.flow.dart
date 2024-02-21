import 'package:fit_worker/views/screens/exercise/exercise.flow.dart';

import 'squat.instruction.dart';
import 'squat.preview.dart';
import 'squat_pose_detector.screen.dart';

var squatFlow = const ExerciseFlow(
  screens: [
    SquatInstructionScreen(),
    SquatPreviewScreen(),
    SquatPoseDetectorView(),
  ],
);
