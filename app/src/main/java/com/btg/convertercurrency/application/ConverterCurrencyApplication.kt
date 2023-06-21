package com.btg.convertercurrency.application

import android.app.Application
import com.btg.convertercurrency.features.currency_converter.di.currencyConverterModule
import com.btg.convertercurrency.features.currency_list.di.listCurrencyModule
import com.btg.convertercurrency.features.home.di.homeModule
import org.koin.android.ext.koin.androidContext
import org.koin.core.context.startKoin

class ConverterCurrencyApplication : Application() {

    override fun onCreate() {
        super.onCreate()
        startKoin {
            androidContext(this@ConverterCurrencyApplication)
            modules(
                listOf(
                    homeModule,currencyConverterModule,listCurrencyModule
                )
            )
        }
    }
}