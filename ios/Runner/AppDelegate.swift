import UIKit
import Flutter


@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {

  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {

    let METHOD_CHANNEL = "fit_worker/camera_view_widget"
    let POSE_CHANNEL = "fit_worker/pose_data_stream"
    let poseDataStreamHandler = PoseDataStreamHandler()
      
    weak var registrar = self.registrar(forPlugin: "NativeCameraView")
      
    let viewFactory = NativeCameraViewFactory(messenger: registrar!.messenger(), poseDataStreamHandler: poseDataStreamHandler)
      self.registrar(forPlugin: "<NativeCameraView>")!.register(
      viewFactory, withId: "fit_worker/camera_view_widget")

//    let methodChannel = FlutterMethodChannel(name: METHOD_CHANNEL, binaryMessenger: controller.binaryMessenger)
//    methodChannel.setMethodCallHandler(
//      {(call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
//        if call.method == "startCamera" {
//          result("Ok")
//        } else {
//          result(FlutterMethodNotImplemented)
//        }
//      }
//    )
//      
    let poseChannel = FlutterEventChannel(name: POSE_CHANNEL, binaryMessenger: registrar!.messenger())
    poseChannel.setStreamHandler(poseDataStreamHandler)
      
    GeneratedPluginRegistrant.register(with: self)

    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
