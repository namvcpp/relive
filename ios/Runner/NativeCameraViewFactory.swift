//
//  FLNativeView.swift
//  Runner
//
//  Created by ios on 06/12/2023.
//

import Flutter
import UIKit

class NativeCameraViewFactory: NSObject, FlutterPlatformViewFactory {
    private var messenger: FlutterBinaryMessenger
    private var poseDataStreamHandler: PoseDataStreamHandler
    
    init(messenger: FlutterBinaryMessenger,  poseDataStreamHandler: PoseDataStreamHandler) {
        self.messenger = messenger
        self.poseDataStreamHandler = poseDataStreamHandler
        super.init()
    }
    
    func create(
        withFrame frame: CGRect,
        viewIdentifier viewId: Int64,
        arguments args: Any?
    ) -> FlutterPlatformView {
        return NativeCameraView(
            frame: frame,
            viewIdentifier: viewId,
            arguments: args,
            binaryMessenger: messenger,
            poseDataStreamHandler: poseDataStreamHandler
        )
    }

    /// Implementing this method is only necessary when the `arguments` in `createWithFrame` is not `nil`.
    public func createArgsCodec() -> FlutterMessageCodec & NSObjectProtocol {
          return FlutterStandardMessageCodec.sharedInstance()
    }
}
