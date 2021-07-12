package com.example.currencies.model.room

import android.content.Context
import androidx.room.Database
import androidx.room.Room
import androidx.room.RoomDatabase
import com.example.currencies.model.remote.CurrenciesModelRemote
import com.example.currencies.model.remote.RatesModelRemote
import com.example.currencies.repository.local.CurrenciesDAO
import com.example.currencies.repository.local.RatesDAO


@Database(entities = [  CurrenciesModelLocal::class,  RatesModelLocal::class], version = 1)

public abstract class CurrenciesDatabase : RoomDatabase() {

    abstract fun CurrenciesDAO(): CurrenciesDAO
    abstract fun RatesDAO(): RatesDAO

    companion object {

        private lateinit var INSTANCE: CurrenciesDatabase
        fun getDatabase(context: Context): CurrenciesDatabase {
            if (!Companion::INSTANCE.isInitialized) {
                synchronized(CurrenciesDatabase::class) {

                    INSTANCE = Room.databaseBuilder(context, CurrenciesDatabase::class.java, "CurrenciesDB")
                        .allowMainThreadQueries()
                        .build()
                }
            }
            return INSTANCE
        }
    }
}