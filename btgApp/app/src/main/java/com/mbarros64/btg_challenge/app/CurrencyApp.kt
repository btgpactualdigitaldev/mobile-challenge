package com.mbarros64.btg_challenge.app

import android.app.Application
import com.mbarros64.btg_challenge.di.*
import org.koin.android.ext.koin.androidContext
import org.koin.core.context.startKoin

class CurrencyApp : Application() {
    override fun onCreate() {
        super.onCreate()
        startKoin {
            androidContext(this@CurrencyApp)
            modules(
                listOf(
                    networkModule,
                    databaseModule,
                    resourceModule,
                    viewModelModule
                )
            )
        }
    }
}