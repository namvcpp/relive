//
//  NativeCameraView.swift
//  Runner
//
//  Created by ios on 07/12/2023.
//

import AVFoundation
import Flutter
import Foundation

class NativeCameraView: NSObject, FlutterPlatformView {
    private var cameraViewController: UIViewController?
    private var poseDataStreamHandler: PoseDataStreamHandler?

    private struct Constants {
        static let storyBoardName = "Main"
        static let cameraViewControllerStoryBoardId = "CAMERA_VIEW_CONTROLLER"
    }
    
    init(
        frame: CGRect,
        viewIdentifier viewId: Int64,
        arguments args: Any?,
        binaryMessenger messenger: FlutterBinaryMessenger?,
        poseDataStreamHandler: PoseDataStreamHandler
    ) {
        self.poseDataStreamHandler = poseDataStreamHandler
        super.init()
        instantiateCameraViewController()
    }
    
    func view() -> UIView {
       guard let cameraViewController = cameraViewController else {
           print("Camera view controller not instantiated")
           return UIView()
       }
        
        return cameraViewController.view
    }

    private func instantiateCameraViewController() {
        guard let viewController = UIStoryboard.init(
            name: Constants.storyBoardName,
            bundle: Bundle.init(for: NativeCameraView.self)
        ).instantiateViewController(
           withIdentifier: Constants.cameraViewControllerStoryBoardId
       ) as? CameraViewController else {
           print("Unable to instantiate camera view controller")
           return
       }
       
       cameraViewController = viewController

       (cameraViewController as! CameraViewController).setPoseDataStreamHandler(poseStreamHandler: poseDataStreamHandler!)
        
//        cameraViewController!.view.frame = CGRect(x: 0, y: 0, width: cameraViewController!.view.frame.width, height: cameraViewController!.view.frame.height)

       print("Camera view controller instantiated")
   }
}
