//
//  PoseOverlay.swift
//  PoseLandmarker
//
//  Created by Trung on 08/12/2023.
//

import UIKit
import PoseLandmarkerSDK

/// Represents a straight line for drawing purposes.
struct Line {
    let from: CGPoint
    let to: CGPoint
}

/// Represents a line connection, including the color and lines to draw.
struct LineConnection {
    let color: UIColor
    let lines: [Line]
}

/// Structure to hold pose landmarks and their connections for drawing.
struct PoseOverlay {
    let dots: [CGPoint]
    let lineConnections: [LineConnection]
}

/// Custom view to visualize pose landmarks on top of an image.
class OverlayView: UIView {

    var poseOverlays: [PoseOverlay] = []
    
    private var contentImageSize: CGSize = CGSizeZero
    var imageContentMode: UIView.ContentMode = .scaleAspectFit
    private var orientation = UIDeviceOrientation.portrait
    
    private var scaleFactor: CGFloat = 1.0
    private var edgeOffset: CGFloat = 0.0

    // MARK: Public Functions
    func draw(
      poseOverlays: [PoseOverlay],
      inBoundsOfContentImageOfSize imageSize: CGSize,
      edgeOffset: CGFloat = 0.0,
      imageContentMode: UIView.ContentMode) {

        self.clear()
        contentImageSize = imageSize
        self.edgeOffset = edgeOffset
        self.poseOverlays = poseOverlays
        self.imageContentMode = imageContentMode
        orientation = UIDevice.current.orientation
        self.setNeedsDisplay()
      }
    
    func redrawPoseOverlays(forNewDeviceOrientation deviceOrientation:UIDeviceOrientation) {

      orientation = deviceOrientation

      switch orientation {
      case .portrait:
        fallthrough
      case .landscapeLeft:
        fallthrough
      case .landscapeRight:
        self.setNeedsDisplay()
      default:
        return
      }
    }

    func clear() {
        poseOverlays = []
        contentImageSize = CGSizeZero
        scaleFactor = 1.0
        imageContentMode = .scaleAspectFit
        orientation = UIDevice.current.orientation
        edgeOffset = 0.0
        setNeedsDisplay()
    }

    override func draw(_ rect: CGRect) {
        for poseOverlay in poseOverlays {
            drawDots(poseOverlay.dots)
            for lineConnection in poseOverlay.lineConnections {
                drawLines(lineConnection.lines, lineColor: lineConnection.color)
            }
        }
    }

    private func drawDots(_ dots: [CGPoint]) {
      for dot in dots {
        let dotRect = CGRect(
          x: CGFloat(dot.x) - DefaultConstants.pointRadius / 2,
          y: CGFloat(dot.y) - DefaultConstants.pointRadius / 2,
          width: DefaultConstants.pointRadius,
          height: DefaultConstants.pointRadius)
        let path = UIBezierPath(ovalIn: dotRect)
        DefaultConstants.pointFillColor.setFill()
        DefaultConstants.pointColor.setStroke()
        path.stroke()
        path.fill()
      }
    }

    private func drawLines(_ lines: [Line], lineColor: UIColor) {
      let path = UIBezierPath()
      for line in lines {
        path.move(to: line.from)
        path.addLine(to: line.to)
      }
      path.lineWidth = DefaultConstants.lineWidth
      lineColor.setStroke()
      path.stroke()
    }

    // MARK: Helper Functions
    static func offsetsAndScaleFactor(
      forImageOfSize imageSize: CGSize,
      tobeDrawnInViewOfSize viewSize: CGSize,
      withContentMode contentMode: UIView.ContentMode)
    -> (xOffset: CGFloat, yOffset: CGFloat, scaleFactor: Double) {

      let widthScale = viewSize.width / imageSize.width;
      let heightScale = viewSize.height / imageSize.height;

      var scaleFactor = 0.0

      switch contentMode {
      case .scaleAspectFill:
        scaleFactor = max(widthScale, heightScale)
      case .scaleAspectFit:
        scaleFactor = min(widthScale, heightScale)
      default:
        scaleFactor = 1.0
      }

      let scaledSize = CGSize(
        width: imageSize.width * scaleFactor,
        height: imageSize.height * scaleFactor)
      let xOffset = (viewSize.width - scaledSize.width) / 2
      let yOffset = (viewSize.height - scaledSize.height) / 2

      return (xOffset, yOffset, scaleFactor)
    }

    // Helper to get object overlays from detections.
    static func poseOverlays(
      fromMultiplePoseLandmarks landmarks: [[NormalizedLandmark]],
      inferredOnImageOfSize originalImageSize: CGSize,
      ovelayViewSize: CGSize,
      imageContentMode: UIView.ContentMode,
      andOrientation orientation: UIImage.Orientation
    ) -> [PoseOverlay] {

        var poseOverlays: [PoseOverlay] = []

        guard !landmarks.isEmpty else {
          return []
        }

        let offsetsAndScaleFactor = OverlayView.offsetsAndScaleFactor(
          forImageOfSize: originalImageSize,
          tobeDrawnInViewOfSize: ovelayViewSize,
          withContentMode: imageContentMode
        )

        for poseLandmarks in landmarks {
          var transformedPoseLandmarks: [CGPoint]!

          switch orientation {
          case .left:
            transformedPoseLandmarks = poseLandmarks.map({CGPoint(x: CGFloat($0.y), y: 1 - CGFloat($0.x))})
          case .right:
            transformedPoseLandmarks = poseLandmarks.map({CGPoint(x: 1 - CGFloat($0.y), y: CGFloat($0.x))})
          default:
            transformedPoseLandmarks = poseLandmarks.map({CGPoint(x: CGFloat($0.x), y: CGFloat($0.y))})
          }

          let dots: [CGPoint] = transformedPoseLandmarks.map({CGPoint(x: CGFloat($0.x) * originalImageSize.width * offsetsAndScaleFactor.scaleFactor + offsetsAndScaleFactor.xOffset, y: CGFloat($0.y) * originalImageSize.height * offsetsAndScaleFactor.scaleFactor + offsetsAndScaleFactor.yOffset)})

          var lineConnections: [LineConnection] = []
            
          lineConnections.append(LineConnection(
            color: DefaultConstants.faceOvalConnectionsColor,
            lines: PoseLandmarker.poseLandmarksConnections
              .map({ connection in
              let start = dots[Int(connection.start)]
              let end = dots[Int(connection.end)]
              return Line(from: start, to: end)
              })))

          poseOverlays.append(PoseOverlay(dots: dots, lineConnections: lineConnections))
        }

        return poseOverlays
      }
  }

