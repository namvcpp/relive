import 'package:flutter/material.dart';

/// Available pose landmarks detected by [PoseDetector].
enum PoseLandmarkType {
  nose,
  leftEyeInner,
  leftEye,
  leftEyeOuter,
  rightEyeInner,
  rightEye,
  rightEyeOuter,
  leftEar,
  rightEar,
  leftMouth,
  rightMouth,
  leftShoulder,
  rightShoulder,
  leftElbow,
  rightElbow,
  leftWrist,
  rightWrist,
  leftPinky,
  rightPinky,
  leftIndex,
  rightIndex,
  leftThumb,
  rightThumb,
  leftHip,
  rightHip,
  leftKnee,
  rightKnee,
  leftAnkle,
  rightAnkle,
  leftHeel,
  rightHeel,
  leftFootIndex,
  rightFootIndex
}

/// Describes a pose detection result.
class Pose {
  /// A map of all the landmarks in the detected pose.
  final Map<PoseLandmarkType, PoseLandmark> landmarks;

  final Map<PoseLandmarkType, PoseLandmark> worldLandmarks;

  /// Constructor to create an instance of [Pose].
  Pose({required this.landmarks, required this.worldLandmarks});

  bool allPoseLandmarksAreInFrame() {
    return landmarks.values.every((element) =>
        element.x >= 0 && element.x <= 1 && element.y >= 0 && element.y <= 1);
  }
}

/// A landmark in a pose detection result.
class PoseLandmark {
  /// The landmark type.
  final PoseLandmarkType type;

  /// Gives x coordinate of landmark in image frame.
  final double x;

  /// Gives y coordinate of landmark in image frame.
  final double y;

  /// Gives z coordinate of landmark in image space.
  final double z;

  final double visibility;
  final double presence;

  /// Constructor to create an instance of [PoseLandmark].
  PoseLandmark({
    required this.type,
    required this.x,
    required this.y,
    required this.z,
    required this.visibility,
    required this.presence,
  });

  /// Returns an instance of [PoseLandmark] from a given [json].
  factory PoseLandmark.fromJson(Map<dynamic, dynamic> json, int index) {
    return PoseLandmark(
      type: PoseLandmarkType.values[index],
      x: json['x'],
      y: json['y'],
      z: json['z'],
      visibility: json['likelihood'] ?? 0.0,
      presence: json['presence'] ?? 0.0,
    );
  }
}

class PoseData {
  final Pose pose;
  final Size inputImageSize;

  PoseData(this.pose, this.inputImageSize);

  factory PoseData.fromMap(Map<dynamic, dynamic> map) {
    return PoseData(
      Pose(
        landmarks: Map<PoseLandmarkType, PoseLandmark>.fromIterables(
          PoseLandmarkType.values,
          List<PoseLandmark>.from(
            map['poseResult']['normalizedLandmarks'].asMap().entries.map(
                (landmark) =>
                    PoseLandmark.fromJson(landmark.value, landmark.key)),
          ),
        ),
        worldLandmarks: Map<PoseLandmarkType, PoseLandmark>.fromIterables(
          PoseLandmarkType.values,
          List<PoseLandmark>.from(
            map['poseResult']['worldLandmarks'].asMap().entries.map(
                (landmark) =>
                    PoseLandmark.fromJson(landmark.value, landmark.key)),
          ),
        ),
      ),
      Size(map['inputImageWidth'] * 1.0, map['inputImageHeight'] * 1.0),
    );
  }
}
