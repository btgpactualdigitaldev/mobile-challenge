package com.example.conversordemoeda.di

import android.app.Application
import com.example.conversordemoeda.di.module.PROPERTY_BASE_URL
import com.example.conversordemoeda.di.module.appModule
import org.koin.android.ext.koin.androidContext
import org.koin.android.ext.koin.androidLogger
import org.koin.core.context.startKoin
import org.koin.core.logger.Level

var BASE_URL: String = ""

fun Application.setUpDI(){
    startKoin {
        androidLogger(Level.ERROR)
        androidContext(this@setUpDI)

        properties(
            mapOf(
                PROPERTY_BASE_URL to BASE_URL
            )
        )
        modules(
            listOf(appModule)
        )
    }
}