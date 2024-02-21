// Copyright 2023 The MediaPipe Authors.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import UIKit
import AVFoundation
import PoseLandmarkerSDK

/**
 This protocol must be adopted by any class that wants to get the detection results of the face landmarker in live stream mode.
 */
protocol PoseLandmarkerServiceLiveStreamDelegate: AnyObject {
  func poseLandmarkerService(_ poseLandmarkerService: PoseLandmarkerService,
                             didFinishDetection result: ResultBundle?,
                             error: Error?)
}

// Initializes and calls the MediaPipe APIs for detection.
class PoseLandmarkerService: NSObject {

  weak var liveStreamDelegate: PoseLandmarkerServiceLiveStreamDelegate?

  var poseLandmarker: PoseLandmarker?
  private(set) var runningMode = RunningMode.liveStream
  private var numPoses: Int
  private var minPoseDetectionConfidence: Float
  private var minPosePresenceConfidence: Float
  private var minTrackingConfidence: Float
  private var computeDelegate: MPPBaseOptionsDelegateType = DefaultConstants.computeDelegate
  var modelPath: String

  // MARK: - Custom Initializer
  private init?(modelPath: String?,
                runningMode:RunningMode,
                numPoses: Int,
                minPoseDetectionConfidence: Float,
                minPosePresenceConfidence: Float,
                minTrackingConfidence: Float) {
    guard let modelPath = modelPath else { return nil }
    self.modelPath = modelPath
    self.runningMode = runningMode
    self.numPoses = numPoses
    self.minPoseDetectionConfidence = minPoseDetectionConfidence
    self.minPosePresenceConfidence = minPosePresenceConfidence
    self.minTrackingConfidence = minTrackingConfidence
    super.init()

    createPoseLandmarker()
  }

  private func createPoseLandmarker() {
    let poseLandmarkerOptions = PoseLandmarkerOptions()
    poseLandmarkerOptions.runningMode = runningMode
    poseLandmarkerOptions.numPoses = numPoses
    poseLandmarkerOptions.minPoseDetectionConfidence = minPoseDetectionConfidence
    poseLandmarkerOptions.minPosePresenceConfidence = minPosePresenceConfidence
    poseLandmarkerOptions.minTrackingConfidence = minTrackingConfidence
    poseLandmarkerOptions.baseOptions.modelAssetPath = modelPath
    poseLandmarkerOptions.baseOptions.delegateType = computeDelegate
      
    if runningMode == .liveStream {
      poseLandmarkerOptions.poseLandmarkerLiveStreamDelegate = self
    }
    do {
        poseLandmarker = try PoseLandmarker(options: poseLandmarkerOptions)
    }
    catch {
      print(error)
    }
  }

  static func liveStreamPoseLandmarkerService(
    modelPath: String?,
    numPoses: Int,
    minPoseDetectionConfidence: Float,
    minPosePresenceConfidence: Float,
    minTrackingConfidence: Float,
    liveStreamDelegate: PoseLandmarkerServiceLiveStreamDelegate?) -> PoseLandmarkerService? {
    let poseLandmarkerService = PoseLandmarkerService(
      modelPath: modelPath,
      runningMode: .liveStream,
      numPoses: numPoses,
      minPoseDetectionConfidence: minPoseDetectionConfidence,
      minPosePresenceConfidence: minPosePresenceConfidence,
      minTrackingConfidence: minTrackingConfidence)
    poseLandmarkerService?.liveStreamDelegate = liveStreamDelegate

    return poseLandmarkerService
  }

  // MARK: - Detection Methods for Different Modes
  /**
   This method return PoseLandmarkerResult and infrenceTime when receive an image
   **/
  func detect(image: UIImage) -> ResultBundle? {
    guard let mpImage = try? MPImage(uiImage: image) else {
      return nil
    }
    do {
      let startDate = Date()
      let result = try poseLandmarker?.detect(image: mpImage)
      let inferenceTime = Date().timeIntervalSince(startDate) * 1000
      return ResultBundle(inferenceTime: inferenceTime, poseLandmarkerResults: [result])
    } catch {
        print(error)
        return nil
    }
  }

  func detectAsync(
    sampleBuffer: CMSampleBuffer,
    orientation: UIImage.Orientation,
    timeStamps: Int) {
    guard let image = try? MPImage(sampleBuffer: sampleBuffer, orientation: orientation) else {
      print("Failed to create image from sample buffer.")
      return
    }
    do {
      try poseLandmarker?.detectAsync(image: image, timestampInMilliseconds: timeStamps)
    } catch {
      print(error)
    }
  }
}

// MARK: - PoseLandmarkerLiveStreamDelegate Methods
extension PoseLandmarkerService: PoseLandmarkerLiveStreamDelegate {
  func poseLandmarker(
    _ poseLandmarker: PoseLandmarker,
    didFinishDetection result: PoseLandmarkerResult?,
    timestampInMilliseconds: Int,
    error: Error?) {
      let resultBundle = ResultBundle(
        inferenceTime: Date().timeIntervalSince1970 * 1000 - Double(timestampInMilliseconds),
        poseLandmarkerResults: [result])
      liveStreamDelegate?.poseLandmarkerService(
        self,
        didFinishDetection: resultBundle,
        error: error)

      if let error = error {
        print(error)
      }
  }
}

/// A result from the `PoseLandmarkerService`.
struct ResultBundle {
  let inferenceTime: Double
  let poseLandmarkerResults: [PoseLandmarkerResult?]
  var size: CGSize = .zero
}
