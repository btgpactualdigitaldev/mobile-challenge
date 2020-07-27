package com.example.challengecpqi

import android.app.Application
import com.example.challengecpqi.di.coreModule
import com.example.challengecpqi.di.repositoryModule
import com.example.challengecpqi.di.viewModelModule
import org.koin.android.ext.koin.androidContext
import org.koin.android.ext.koin.androidLogger
import org.koin.core.context.startKoin

class MainApplication : Application() {

    override fun onCreate() {
        super.onCreate()

        startKoin {
            androidLogger()
            androidContext(this@MainApplication)
            modules(coreModule, repositoryModule, viewModelModule)
        }
    }
}