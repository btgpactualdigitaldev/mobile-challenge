package com.vald3nir.btg_challenge.core

import android.app.Application
import com.vald3nir.btg_challenge.core.di.appModule
import com.vald3nir.data.di.dataModule
import org.koin.android.ext.koin.androidContext
import org.koin.core.context.startKoin
import org.koin.core.context.unloadKoinModules

class MainApplication : Application() {

    private val modules by lazy {
        listOf(dataModule, appModule)
    }

    override fun onCreate() {
        super.onCreate()
        startKoin {
            androidContext(this@MainApplication)
            modules(modules)
        }
    }

    override fun onTerminate() {
        super.onTerminate()
        unloadKoinModules(modules)
    }
}