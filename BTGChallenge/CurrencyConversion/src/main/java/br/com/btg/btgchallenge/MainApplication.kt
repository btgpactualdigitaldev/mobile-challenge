package br.com.btg.btgchallenge

import android.app.Application
import br.com.btg.btgchallenge.di.apiModule
import br.com.btg.btgchallenge.di.viewModelModule
import br.com.btg.btgchallenge.network.api.GetTrueTime
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.runBlocking
import kotlinx.coroutines.withContext
import org.koin.android.ext.koin.androidContext
import org.koin.android.ext.koin.androidFileProperties
import org.koin.android.ext.koin.androidLogger
import org.koin.core.context.startKoin

open class MainApplication : Application() {

    override fun onCreate() {
        super.onCreate()

        runBlocking {
            GetTrueTime.getTrueTime()
        }

        startKoin {
            androidLogger()
            androidContext(this@MainApplication)
            androidFileProperties()
            modules(listOf(viewModelModule, apiModule))
        }
    }
}