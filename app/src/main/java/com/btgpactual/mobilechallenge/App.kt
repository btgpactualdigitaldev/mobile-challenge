package com.btgpactual.mobilechallenge

import android.app.Application
import com.btgpactual.data.di.dataModules
import com.btgpactual.domain.di.domainModule
import com.btgpactual.mobilechallenge.di.presentationModule
import org.koin.android.ext.koin.androidContext
import org.koin.core.context.startKoin

class App  : Application() {

    override fun onCreate() {
        super.onCreate()
        startKoin {
            androidContext(this@App)

            modules(domainModule + dataModules + presentationModule)
        }
    }
}