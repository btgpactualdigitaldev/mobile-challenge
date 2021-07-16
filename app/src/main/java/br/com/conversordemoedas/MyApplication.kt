package br.com.conversordemoedas

import android.app.Application
import br.com.conversordemoedas.di.DependencyModules
import org.koin.android.ext.android.startKoin

class MyApplication: Application() {

    override fun onCreate() {
        super.onCreate()

        startKoin(this, listOf(DependencyModules.appModule))

    }

}