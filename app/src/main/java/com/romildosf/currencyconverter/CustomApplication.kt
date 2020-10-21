package com.romildosf.currencyconverter

import android.app.Application
import com.romildosf.currencyconverter.injection.AppModule
import org.koin.android.ext.koin.androidContext
import org.koin.android.ext.koin.androidLogger
import org.koin.core.context.startKoin
import org.koin.core.logger.Level

class CustomApplication: Application() {

    override fun onCreate() {
        super.onCreate()

        startKoin {
            androidLogger(Level.ERROR)
            androidContext(this@CustomApplication)

            modules(AppModule(this@CustomApplication).subModules)
        }
    }
}