package com.btgpactual.teste.mobile_challenge.di

import com.btgpactual.teste.mobile_challenge.MainApplication
import com.btgpactual.teste.mobile_challenge.data.remote.sync.SyncManager
import dagger.BindsInstance
import dagger.Component
import dagger.android.AndroidInjector
import dagger.android.support.AndroidSupportInjectionModule
import javax.inject.Singleton

/**
 * Created by Carlos Souza on 16,October,2020
 */
@Singleton
@Component(
    modules = [
        AndroidSupportInjectionModule::class,
        ActivityBuildersModule::class,
        AppModule::class,
        DaoDBModule::class,
        DataSourceDBModule::class,
        PreferencesModule::class,
        ViewModelFactoryModule::class
    ]
)
interface AppComponent: AndroidInjector<MainApplication> {

    var syncManager: SyncManager

    @Component.Builder
    interface Builder {
        @BindsInstance
        fun mainApplication(mainApplication: MainApplication): Builder

        fun build(): AppComponent
    }
}