package com.hotmail.fignunes.desafio_mobile.repository.remote

import android.app.Application
import com.hotmail.fignunes.btg.di.ActionsModule
import com.hotmail.fignunes.btg.di.PresenterModule
import com.hotmail.fignunes.btg.repository.di.RepositoryModule
import com.hotmail.fignunes.btg.repository.di.RoomModule
import net.danlew.android.joda.JodaTimeAndroid
import org.koin.android.ext.koin.androidContext
import org.koin.core.context.startKoin

class TestApp : Application() {

    override fun onCreate() {
        super.onCreate()
        JodaTimeAndroid.init(this)
        startKoin {
            androidContext(this@TestApp)
            modules(
                PresenterModule.presenterModule,
                ActionsModule.actionsModule,
                RepositoryModule.repositoryModule,
                RoomModule.roomModule
            )
        }
    }
}