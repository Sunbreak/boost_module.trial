package com.example.myandroid

import android.os.Bundle
import android.widget.Button
import androidx.appcompat.app.AppCompatActivity
import com.idlefish.flutterboost.FlutterBoost
import com.idlefish.flutterboost.FlutterBoostRouteOptions

class MainActivity : AppCompatActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)
        findViewById<Button>(R.id.go_flutter).setOnClickListener {
            val options = FlutterBoostRouteOptions.Builder()
                .pageName("flutter").arguments(mapOf()).build()
            FlutterBoost.instance().open(options)
        }
    }
}