
package com.example.ecocompute

import android.app.ActivityManager
import android.content.Context
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {

    private val CHANNEL = "com.example.ecocompute/memory"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            CHANNEL
        ).setMethodCallHandler { call, result ->

            if (call.method == "getMemoryInfo") {
                try {
                    val activityManager =
                        getSystemService(Context.ACTIVITY_SERVICE) as ActivityManager

                    val memoryInfo = ActivityManager.MemoryInfo()
                    activityManager.getMemoryInfo(memoryInfo)

                    val memoryData = mapOf(
                        "totalRamBytes" to memoryInfo.totalMem,
                        "availableRamBytes" to memoryInfo.availMem
                    )

                    result.success(memoryData)
                } catch (e: Exception) {
                    result.error(
                        "MEMORY_ERROR",
                        "Unable to retrieve memory information",
                        e.message
                    )
                }
            } else {
                result.notImplemented()
            }
        }
    }
}
