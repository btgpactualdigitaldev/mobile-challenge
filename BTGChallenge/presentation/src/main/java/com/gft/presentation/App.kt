package com.gft.presentation

import android.app.Application
import com.gft.presentation.di.networkModule
import com.gft.presentation.di.repositoryModule
import com.gft.presentation.di.useCasesModule
import com.gft.presentation.di.viewModelModule
import org.koin.android.ext.android.startKoin

class App : Application() {
    override fun onCreate() {
        super.onCreate()
        setupKoin()
    }

    private fun setupKoin() {
        startKoin(
            this, listOf(
                repositoryModule,
                useCasesModule,
                networkModule,
                viewModelModule
            )
        )
    }
}