package com.helano.currencyconverter

import android.app.Application
import com.helano.shared.util.network.ConnectivityStateHolder.registerConnectivityBroadcaster
import dagger.hilt.android.HiltAndroidApp

@HiltAndroidApp
class MainApplication : Application() {

    override fun onCreate() {
        super.onCreate()
        registerConnectivityBroadcaster()
    }
}