package com.example.conversordemoeda

import android.app.Application
import com.example.conversordemoeda.di.BASE_URL
import com.example.conversordemoeda.di.setUpDI

open class App: Application() {

    override fun onCreate() {
        super.onCreate()
        BASE_URL = getUrlBase()
        setUpDI()
    }

    open fun getUrlBase() = BuildConfig.BASE_URL
}