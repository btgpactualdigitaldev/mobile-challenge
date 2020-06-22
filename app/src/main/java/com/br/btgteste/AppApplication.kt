package com.br.btgteste

import android.app.Application
import com.br.btgteste.di.listModules
import org.koin.android.ext.android.startKoin

open class AppApplication: Application() {

    override fun onCreate() {
        super.onCreate()
        startKoin(modules = listModules, context = this)
    }
}