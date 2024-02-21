package com.example.fit_worker

import android.app.Activity
import android.content.Context
import androidx.lifecycle.LifecycleOwner
import io.flutter.embedding.android.FlutterFragmentActivity
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.StandardMessageCodec
import io.flutter.plugin.platform.PlatformView
import io.flutter.plugin.platform.PlatformViewFactory

class NativeViewFactory(
    private val viewModel: MainViewModel,
    private val activity: FlutterFragmentActivity,
    private val owner: LifecycleOwner,
    private val cameraController: CameraController,
    private val poseDataStreamHandler: PoseDataStreamHandler,
    private val messenger: BinaryMessenger
) :
    PlatformViewFactory(StandardMessageCodec.INSTANCE) {
    override fun create(context: Context, viewId: Int, args: Any?): PlatformView {
        return NativeCameraView(context, viewModel, activity, owner, cameraController, poseDataStreamHandler, messenger, viewId)
    }
}