package com.btg.conversormonetario

import android.app.Application
import com.btg.conversormonetario.data.model.InfoCurrencyModel
import com.btg.conversormonetario.di.*
import org.koin.android.ext.koin.androidContext
import org.koin.android.ext.koin.androidLogger
import org.koin.core.context.startKoin
import org.koin.core.logger.Level

open class App : Application() {
    var hasInternet: Boolean = true

    override fun onCreate() {
        super.onCreate()
        appInstance = this

        startKoin {
            androidLogger(level = Level.INFO)
            androidContext(this@App)
            modules(
                listOf(
                    viewModelModules,
                    adapterModules,
                    fragmentModules,
                    repositoryModules,
                    serviceModules,
                    dataManagerModules
                )
            )
        }
    }

    companion object {
        private var appInstance: App? = null
        private var infoCurrency: InfoCurrencyModel.Storage? = null

        @Synchronized
        fun getInstance(): App {
            if (appInstance == null) {
                val app = App()
                app.onCreate()
            }
            return appInstance!!
        }

        @Synchronized
        fun getInfoCurrencyData(): InfoCurrencyModel.Storage? {
            return infoCurrency
        }

        fun setInfoCurrency(infoCurrency: InfoCurrencyModel.Storage) {
            this.infoCurrency = infoCurrency
        }
    }
}