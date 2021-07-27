package com.btgpactual.mobilechallenge.features.splash

import android.content.Intent
import android.os.Bundle
import android.view.animation.Animation
import android.view.animation.AnimationUtils.loadAnimation
import androidx.appcompat.app.AppCompatActivity
import androidx.databinding.DataBindingUtil
import com.btgpactual.mobilechallenge.R
import com.btgpactual.mobilechallenge.databinding.ActivitySplashBinding
import com.btgpactual.mobilechallenge.features.converter.ConverterActivity


class SplashActivity : AppCompatActivity() {

    private lateinit var binding : ActivitySplashBinding
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        binding = DataBindingUtil.setContentView(this,R.layout.activity_splash)
        runBounceAnimation()
    }

    private fun runBounceAnimation(){
        val myAnim = loadAnimation(this, R.anim.bounce_vertical)
        myAnim.setAnimationListener(object : Animation.AnimationListener{
            override fun onAnimationRepeat(p0: Animation?) {}


            override fun onAnimationEnd(p0: Animation?) {
                finish()
                startActivity(Intent(this@SplashActivity,ConverterActivity::class.java))
            }

            override fun onAnimationStart(p0: Animation?) {}


        })
        binding.iconImageView.startAnimation(myAnim)
    }


}
