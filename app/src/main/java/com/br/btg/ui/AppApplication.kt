package com.br.btg.ui

import android.app.Application
import com.br.btg.modules.appModules
import org.koin.android.ext.koin.androidContext
import org.koin.android.ext.koin.androidFileProperties
import org.koin.core.context.startKoin


class AppApplication : Application() {

    override fun onCreate() {
        super.onCreate()
        startKoin {
            androidContext(this@AppApplication)
            androidFileProperties()
            modules(appModules)
        }
    }

}
