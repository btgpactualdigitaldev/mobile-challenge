package br.com.btg.mobile.challenge

import android.app.Application
import androidx.multidex.MultiDex
import br.com.btg.mobile.challenge.di.appModule
import org.koin.android.ext.koin.androidContext
import org.koin.core.context.startKoin

class App : Application() {

    override fun onCreate() {
        super.onCreate()
        setupKoin()
        MultiDex.install(this)
    }

    private fun setupKoin() {
        startKoin {
            modules(appModule)
            androidContext(this@App)
        }
    }
}
