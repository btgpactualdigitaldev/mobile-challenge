package com.hotmail.fignunes.btg.repository.di

import androidx.room.Room
import com.hotmail.fignunes.btg.repository.local.currency.entity.CurrencyBean
import com.hotmail.fignunes.btg.repository.local.currency.entity.CurrencyDatabase
import org.koin.android.ext.koin.androidApplication
import org.koin.dsl.module

object RoomModule {

    val roomModule = module {
        single {
            Room.databaseBuilder(
                androidApplication(),
                CurrencyDatabase::class.java,
                CurrencyBean.TABLE
            ).fallbackToDestructiveMigration().build()
        }
    }
}