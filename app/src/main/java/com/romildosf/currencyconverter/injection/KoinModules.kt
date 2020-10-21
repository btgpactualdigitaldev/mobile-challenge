package com.romildosf.currencyconverter.injection

import android.app.Application
import org.koin.android.ext.koin.androidContext
import org.koin.android.ext.koin.androidLogger
import org.koin.core.context.startKoin

object KoinModules {

    fun init(application: Application) {
        startKoin {
            androidLogger()
            androidContext(application)
            modules(listOf())
        }
    }

}