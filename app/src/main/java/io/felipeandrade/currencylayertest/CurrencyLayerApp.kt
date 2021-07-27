package io.felipeandrade.currencylayertest

import android.app.Application
import io.felipeandrade.currencylayertest.di.currencyModule
import io.felipeandrade.data.di.dataModule
import org.koin.android.ext.koin.androidContext
import org.koin.core.context.startKoin

class CurrencyLayerApp : Application() {

    override fun onCreate() {
        super.onCreate()
        initDependencyInjection()
    }

    private fun initDependencyInjection() {
        startKoin {
            androidContext(this@CurrencyLayerApp)
            modules(listOf(currencyModule, dataModule))
        }
    }
}