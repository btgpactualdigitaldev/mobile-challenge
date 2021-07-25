package com.example.mobile_challenge

import android.app.Application
import androidx.room.Room
import com.example.mobile_challenge.db.AppDatabase
import com.example.mobile_challenge.utility.ClientApi

class App: Application() {

    companion object {
        lateinit var instance: App

        lateinit var db : AppDatabase

        val clientApi: ClientApi by lazy {
            ClientApi()
        }
    }

    override fun onCreate() {
        super.onCreate()
        instance = this
        db = Room.databaseBuilder(
            applicationContext,
            AppDatabase::class.java, "mobile-challenge-db"
        ).build()
    }
}