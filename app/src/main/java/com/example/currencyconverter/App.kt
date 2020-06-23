package com.example.currencyconverter

import android.app.Application
import io.realm.Realm

class App: Application() {

    override fun onCreate() {
        super.onCreate()
        setupRealm()
    }

    private fun setupRealm() {
        Realm.init(this)
    }
}