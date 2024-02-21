import 'package:fit_worker/views/screens/exercise/exercise.flow.dart';

import 'heelraise.instruction.dart';
import 'heelraise.preview.dart';
import 'heelraise_pose_detector.screen.dart';

var heelRaiseFlow = const ExerciseFlow(
  screens: [
    HeelRaiseInstructionScreen(),
    HeelRaisePreviewScreen(),
    HeelRaisePoseDetectorView(),
  ],
);
