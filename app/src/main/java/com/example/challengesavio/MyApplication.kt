package com.example.challengesavio

import android.app.Application
import androidx.room.Room
import com.example.challengesavio.data.database.AppDatabase
import com.example.challengesavio.di.networkModule
import com.example.challengesavio.di.repository
import com.example.challengesavio.di.viewModelModule
import org.koin.android.ext.koin.androidContext
import org.koin.core.context.startKoin


class MyApplication : Application() {

    companion object{
        var database : AppDatabase? = null
    }

    override fun onCreate() {
        super.onCreate()
        //        Room
        database= Room.databaseBuilder(this, AppDatabase::class.java, "my_db").allowMainThreadQueries().build()

// start Koin!
        startKoin {
            // declare used Android context
            androidContext(this@MyApplication)
            // declare modules
            modules(listOf(
                viewModelModule,
                repository,
                networkModule
            ))
        }

    }

}