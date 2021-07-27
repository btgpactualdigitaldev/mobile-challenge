package com.hotmail.fignunes.btg

import android.app.Application
import com.facebook.stetho.Stetho
import com.hotmail.fignunes.btg.di.ActionsModule
import com.hotmail.fignunes.btg.di.PresenterModule
import com.hotmail.fignunes.btg.repository.di.RepositoryModule
import com.hotmail.fignunes.btg.repository.di.RoomModule
import net.danlew.android.joda.JodaTimeAndroid
import org.koin.android.ext.koin.androidContext
import org.koin.core.context.startKoin

class MobileChallenge : Application() {

    override fun onCreate() {
        super.onCreate()
        Stetho.initializeWithDefaults(this)
        JodaTimeAndroid.init(this)
        startKoin {
            androidContext(this@MobileChallenge)
            modules(
                PresenterModule.presenterModule,
                ActionsModule.actionsModule,
                RoomModule.roomModule,
                RepositoryModule.repositoryModule
            )
        }
    }
}