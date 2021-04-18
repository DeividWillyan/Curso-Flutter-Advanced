package com.example.android_native_app

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngineCache
import io.flutter.plugin.common.MethodChannel

class CustomFlutterActivity: FlutterActivity() {
    private val CHANNEL = "com.example.androidnativeapp/navigate"

    companion object {
        fun withCachedEngine(engineId: String) = CustomCachedEngineIntentBuilder(engineId)
    }

    class CustomCachedEngineIntentBuilder(engineId: String) :
        CachedEngineIntentBuilder(CustomFlutterActivity::class.java, engineId)

    override fun onResume() {
        super.onResume()
        MethodChannel(
            FlutterEngineCache.getInstance()["my_engine_id"]!!.dartExecutor
                .binaryMessenger, CHANNEL
        )
            .invokeMethod("notifyNavToFlutter", intent.getStringExtra("screen"))
    }
}