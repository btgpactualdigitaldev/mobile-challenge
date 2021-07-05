package com.example.currencyconverter.app

import android.app.Application
import org.koin.android.ext.koin.androidContext

import org.koin.core.context.startKoin
import com.example.currencyconverter.di.*

class CurrencyConverter: Application() {
    override fun onCreate() {
        super.onCreate()
        startKoin {
            androidContext(this@CurrencyConverter)
            modules(
                viewModelModule,
                networkModule,
                databaseModule
            )
        }
    }
}