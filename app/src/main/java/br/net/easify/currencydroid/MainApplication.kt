package br.net.easify.currencydroid

import android.app.Application
import br.net.easify.currencydroid.di.component.AppComponent
import br.net.easify.currencydroid.di.component.DaggerAppComponent
import br.net.easify.currencydroid.di.module.AppModule

class MainApplication : Application() {
    private lateinit var appComponent: AppComponent
    override fun onCreate() {
        super.onCreate()
        this.appComponent = DaggerAppComponent.builder()
            .application(AppModule(this))
            .build()
    }

    fun getAppComponent(): AppComponent? {
        return appComponent
    }
}