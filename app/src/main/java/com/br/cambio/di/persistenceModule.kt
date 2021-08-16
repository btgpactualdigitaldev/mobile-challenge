package com.br.cambio.di

import androidx.room.Room
import com.br.cambio.R
import com.br.cambio.data.local.AppDatabase
import org.koin.android.ext.koin.androidApplication
import org.koin.dsl.module

val persistenceModule = module {

    factory {
        Room.databaseBuilder(
            androidApplication(),
            AppDatabase::class.java,
            androidApplication().getString(R.string.database)
        )
            .fallbackToDestructiveMigration()
            .build()
    }

    factory { get<AppDatabase>().currencyDao() }
    factory { get<AppDatabase>().priceDao() }
}