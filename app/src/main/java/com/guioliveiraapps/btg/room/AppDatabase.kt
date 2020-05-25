package com.guioliveiraapps.btg.room

import android.content.Context
import androidx.room.Database
import androidx.room.Room
import androidx.room.RoomDatabase

@Database(entities = [Quote::class, Currency::class], version = 1)
abstract class AppDatabase : RoomDatabase() {
    abstract fun quoteDao(): QuoteDao
    abstract fun currencyDao(): CurrencyDao

    companion object {
        private var INSTANCE: AppDatabase? = null
        fun getInstance(context: Context): AppDatabase {
            if (INSTANCE == null) {
                INSTANCE = Room.databaseBuilder(
                    context,
                    AppDatabase::class.java,
                    "roomdb"
                )
                    .allowMainThreadQueries()
                    .build()
            }

            return INSTANCE as AppDatabase
        }
    }
}