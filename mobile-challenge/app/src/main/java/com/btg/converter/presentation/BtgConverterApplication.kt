package com.btg.converter.presentation

import android.app.Application
import com.btg.converter.presentation.di.*
import org.koin.android.ext.koin.androidContext
import org.koin.core.context.startKoin

class BtgConverterApplication : Application() {

    override fun onCreate() {
        super.onCreate()
        startKoin {
            androidContext(this@BtgConverterApplication)
            modules(
                listOf(
                    networkingModule(),
                    viewModelModule(),
                    databaseModule(),
                    repositoryModule(),
                    interactorModule(),
                    resourceModule()
                )
            )
        }
    }
}