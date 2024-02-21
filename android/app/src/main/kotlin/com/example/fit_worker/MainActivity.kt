package com.example.fit_worker

import android.content.Context
import android.util.AttributeSet
import android.util.Log
import android.view.View
import androidx.lifecycle.LifecycleOwner
import androidx.lifecycle.ViewModelProvider
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.android.FlutterFragmentActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel


class MainActivity : FlutterFragmentActivity(), MethodChannel.MethodCallHandler {

    private val METHOD_CHANNEL = "fit_worker/camera_view_widget"
    private val POSE_CHANNEL = "fit_worker/pose_data_stream"

    private val TAG: String = "CameraViewPlugin"

    private var controller: CameraController = CameraController()

    private lateinit var methodChannel : MethodChannel
    private lateinit var poseChannel: EventChannel
    private lateinit var poseDataStreamHandler : PoseDataStreamHandler

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        val owner = this as LifecycleOwner
        Log.d(TAG, "Owner is $owner")

        val viewModel = ViewModelProvider(this).get(MainViewModel::class.java)

        methodChannel = MethodChannel(flutterEngine.dartExecutor.binaryMessenger, "fit_worker/camera_view_widget")
        methodChannel.setMethodCallHandler(this)

        poseChannel = EventChannel(flutterEngine.dartExecutor.binaryMessenger, POSE_CHANNEL)
        poseDataStreamHandler = PoseDataStreamHandler()
        poseChannel.setStreamHandler(poseDataStreamHandler)

        flutterEngine
            .platformViewsController
            .registry
            .registerViewFactory(
                METHOD_CHANNEL,
                NativeViewFactory(viewModel, this, owner, controller, poseDataStreamHandler, flutterEngine.dartExecutor.binaryMessenger)
            )

        controller.setLifecycleProvider(ProxyLifecycleProvider(this))
    }

    override fun onDestroy() {
        super.onDestroy()
        methodChannel.setMethodCallHandler(null)
    }

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        when (call.method) {
            "startCamera" -> {
                Log.d(TAG, "Calling startCamera")
                result.success(null)
            }
            else -> {
                result.notImplemented()
            }
        }
    }
}