package com.example.method_channel

import android.os.Handler
import android.os.Looper
import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.EventChannel
import java.text.SimpleDateFormat
import java.util.*

class MainActivity: FlutterActivity() {

 private val CHANNEL = "unique.identifier.method/hello"
 private val CHANNEL_STREAM = "unique.identifier.method/stream"

  override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
    super.configureFlutterEngine(flutterEngine)

    MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler {
      call, result ->
      if (call.method == "getHelloWorld") {
          val user: String? = call.argument("user");
          if(user == null) {
            result.success("Hello World")
          } else {
            result.success("Hello World, ${user}");
            MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).invokeMethod("methodCallback", "result callback kt");
          }
      } else {
          result.notImplemented()
      }
    }


    
    EventChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL_STREAM).setStreamHandler(
      object : EventChannel.StreamHandler {
        override fun onListen(args: Any?, events: EventChannel.EventSink) {
            var handler = Handler(Looper.getMainLooper())
            handler.postDelayed(object : Runnable {
                override fun run() {
                    val sdf = SimpleDateFormat("dd/M/yyyy hh:mm:ss")
                    val currentDate = sdf.format(Date())
                    events.success(currentDate)
                    handler.postDelayed(this, 1000)
                }
            }, 0)
        }

        override fun onCancel(arguments: Any?) {
            println("cancelling listener")
        }
      }
    )


  }
}
