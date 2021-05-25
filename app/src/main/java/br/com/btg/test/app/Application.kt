package br.com.btg.test.app

import android.app.Application
import br.com.btg.test.di.NetworkModule
import org.koin.android.ext.koin.androidContext
import org.koin.core.context.startKoin


class Application : Application() {

    override fun onCreate() {
        super.onCreate()
        startKoin {
            androidContext(this@Application)
            koin.loadModules(listOf(NetworkModule.networkModule))
        }
    }
}