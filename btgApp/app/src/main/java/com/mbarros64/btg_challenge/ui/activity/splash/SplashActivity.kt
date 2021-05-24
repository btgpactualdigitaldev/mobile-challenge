package com.mbarros64.btg_challenge.ui.activity.splash

import android.content.Intent
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.os.Handler
import android.os.Looper
import com.mbarros64.btg_challenge.R
import com.mbarros64.btg_challenge.ui.activity.MainActivity

class SplashActivity : AppCompatActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_splash)

        val SPLASH_TIME_OUT = 2000

        val homeIntent = Intent(this@SplashActivity, MainActivity::class.java)
        Handler(Looper.getMainLooper()).postDelayed({
            startActivity(homeIntent)
            finish()
        }, SPLASH_TIME_OUT.toLong())
    }
}