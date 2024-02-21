import 'dart:math';

import 'package:fit_worker/services/pose_detector.dart';

double angleCalculate(PoseLandmark A, PoseLandmark B, PoseLandmark C) {
  List<double> vectorBA = [
    A.x - B.x,
    A.y - B.y,
    A.z - B.z,
  ];
  List<double> vectorBC = [
    C.x - B.x,
    C.y - B.y,
    C.z - B.z,
  ];

  // Calculate the dot product of AB and BC
  double dotProduct = vectorBA[0] * vectorBC[0] +
      vectorBA[1] * vectorBC[1] +
      vectorBA[2] * vectorBC[2];

  // Calculate the magnitudes of AB and BC
  double magnitudeBA = sqrt(vectorBA[0] * vectorBA[0] +
      vectorBA[1] * vectorBA[1] +
      vectorBA[2] * vectorBA[2]);

  double magnitudeBC = sqrt(vectorBC[0] * vectorBC[0] +
      vectorBC[1] * vectorBC[1] +
      vectorBC[2] * vectorBC[2]);

  // Calculate the angle in radians using the dot product formula
  double angleRadians = acos(dotProduct / (magnitudeBA * magnitudeBC));

  // Convert the angle from radians to degrees
  double angleDegrees = angleRadians * (180 / pi);

  return angleDegrees;
}

double distanceCalculate(PoseLandmark A, PoseLandmark B) {
  List<double> vectorBA = [
    A.x - B.x,
    A.y - B.y,
    A.z - B.z,
  ];

  // Calculate the squared distance between points A and B
  double squaredDist = vectorBA[0] * vectorBA[0] +
      vectorBA[1] * vectorBA[1] +
      vectorBA[2] * vectorBA[2];

  // Return the square root of the squared distance
  return sqrt(squaredDist);
}
