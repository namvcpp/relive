package com.example.fit_worker

import android.util.Log
import androidx.lifecycle.DefaultLifecycleObserver
import androidx.lifecycle.LifecycleOwner

class CameraController : DefaultLifecycleObserver {
    private lateinit var view : NativeCameraView
    private val TAG: String = "CameraController"

    private var initialized: Boolean = false

    fun setView(view: NativeCameraView) {
        this.view = view
        initialized = true

        view.onCreate()
    }

    fun setLifecycleProvider(proxyLifecycleProvider: ProxyLifecycleProvider) {
        proxyLifecycleProvider.lifecycle.addObserver(this)
    }

    override fun onPause(owner: LifecycleOwner) {
        if (!initialized) {
            return;
        }

        Log.d(TAG, "onPause")

        super.onPause(owner)
        view.onPause()
    }

    override fun onResume(owner: LifecycleOwner) {
        if (!initialized) {
            return;
        }

        Log.d(TAG, "onResume")

        super.onResume(owner)
        view.onResume()
    }

    override fun onDestroy(owner: LifecycleOwner) {
        if (!initialized) {
            return;
        }

        Log.d(TAG, "onDestroy")

        super.onDestroy(owner)
        view.onDestroyView()
    }
}