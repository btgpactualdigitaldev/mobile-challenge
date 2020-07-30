package br.com.mobilechallenge.view

import android.content.Intent
import android.os.Bundle
import androidx.appcompat.app.AppCompatActivity
import android.os.Handler

import br.com.mobilechallenge.R
import br.com.mobilechallenge.presenter.splashscreen.Presenter
import br.com.mobilechallenge.presenter.splashscreen.MVP
import br.com.mobilechallenge.utils.UtilsAnimation

class SplashScreen : AppCompatActivity(R.layout.activity_splashscreen), MVP.View {
    private val seconds: Long = 2000
    private lateinit var presenter: MVP.Presenter

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        presenter = Presenter()
        presenter.setView(this)
        presenter.retriveData()
    }

    override fun loadData() {
        Handler().postDelayed({
            val intent = Intent(this, MainActivity::class.java)

            startActivity(intent)
            finish()
            UtilsAnimation.leftToRight(this)
        }, seconds)
    }
}