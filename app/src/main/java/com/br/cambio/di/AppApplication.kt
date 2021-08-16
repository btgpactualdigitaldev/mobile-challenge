package com.br.cambio.di

import com.google.android.play.core.splitcompat.SplitCompatApplication
import org.koin.android.ext.koin.androidContext
import org.koin.core.context.startKoin

class AppApplication : SplitCompatApplication() {
    override fun onCreate() {
        super.onCreate()
        startKoin {
            androidContext(this@AppApplication)
            modules(persistenceModule)
            modules(domainModules)
            modules(dataModules)
            modules(presentationModules)
            modules(anotherModules)
        }
    }
}