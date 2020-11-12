package com.example.selendra_marketplace_app



// import io.flutter.embedding.android.FlutterActivity

// class MainActivity: FlutterActivity() {
  

// }

import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import androidx.core.app.NotificationCompat



class MainActivity: FlutterActivity() {
  private val CHANNEL = "samples.flutter.dev/notification"
  
  override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
    super.configureFlutterEngine(flutterEngine)
    MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler {
      call, result -> 

  
      // Note: this method is invoked on the main thread.
      // TODO
    }
  }

  private fun showNotification (){
      var notification = NotificationCompat.Builder(this@MainActivity, "")
        .setContentTitle("New Messages")
        .setContentText("You've received 3 new messages.")
        .setSmallIcon(R.drawable.launch_background)
        .setBadgeIconType(NotificationCompat.BADGE_ICON_SMALL)
        .build()

  }
}



