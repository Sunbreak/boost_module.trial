package com.example.myandroid

import android.app.Application
import android.content.Intent
import com.idlefish.flutterboost.FlutterBoost
import com.idlefish.flutterboost.FlutterBoostDelegate
import com.idlefish.flutterboost.FlutterBoostRouteOptions
import com.idlefish.flutterboost.containers.FlutterBoostActivity
import io.flutter.embedding.android.FlutterActivityLaunchConfigs


class App : Application() {
    override fun onCreate() {
        super.onCreate()
        FlutterBoost.instance().setup(this, flutterBoostDelegate) { engine -> }
    }

    private val flutterBoostDelegate = object : FlutterBoostDelegate {
        override fun pushNativeRoute(options: FlutterBoostRouteOptions) {
            val currentActivity = FlutterBoost.instance().currentActivity()
            when (options.pageName()) {
                "main" -> {
                    val intent = Intent(currentActivity, MainActivity::class.java)
                    currentActivity.startActivityForResult(intent, options.requestCode())
                }
            }
        }

        override fun pushFlutterRoute(options: FlutterBoostRouteOptions) {
            val intent = FlutterBoostActivity.CachedEngineIntentBuilder(
                FlutterBoostActivity::class.java
            )
                .backgroundMode(FlutterActivityLaunchConfigs.BackgroundMode.transparent)
                .destroyEngineWithActivity(false)
                .uniqueId(options.uniqueId())
                .url(options.pageName())
                .urlParams(options.arguments())
                .build(FlutterBoost.instance().currentActivity())
            FlutterBoost.instance().currentActivity().startActivity(intent)
        }
    }
}