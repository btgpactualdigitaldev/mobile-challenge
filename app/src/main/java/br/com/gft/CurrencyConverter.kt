package br.com.gft

import android.app.Application
import android.content.Context
import br.com.gft.infrastructure.injection.NetworkModule
import br.com.gft.main.injection.MainModule
import org.koin.core.context.startKoin

class CurrencyConverter: Application() {
    companion object {
        lateinit  var appContext: Context
    }

    override fun onCreate() {
        super.onCreate()
        appContext = applicationContext

        setupInjection()
    }

    private fun setupInjection() {
        val listModules = listOf(
            MainModule.dependencyModule,
            NetworkModule.dependencyModule
        )

        startKoin {
            modules(listModules)
        }
    }
}
