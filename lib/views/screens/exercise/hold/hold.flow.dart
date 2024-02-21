import 'package:fit_worker/views/screens/exercise/exercise.flow.dart';

import 'hold.instruction.dart';
import 'hold.preview.dart';
import 'hold_pose_detector.screen.dart';

var holdFlow = const ExerciseFlow(
  screens: [
    HoldInstructionScreen(),
    HoldPreviewScreen(),
    HoldPoseDetectorView(),
  ],
);
