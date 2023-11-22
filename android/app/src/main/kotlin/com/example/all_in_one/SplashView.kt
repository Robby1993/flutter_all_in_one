package com.example.all_in_one
import android.content.Context
import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import com.example.all_in_one.R.*
import io.flutter.embedding.android.SplashScreen

class SplashView : SplashScreen {
    override fun createSplashView(context: Context, savedInstanceState: Bundle?): View? =
            LayoutInflater.from(context).inflate(layout.splash_view, null, false)

    override fun transitionToFlutter(onTransitionComplete: Runnable) {
        onTransitionComplete.run()
    }
}