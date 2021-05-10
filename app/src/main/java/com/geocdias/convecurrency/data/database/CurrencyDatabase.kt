package com.geocdias.convecurrency.data.database

import android.content.Context
import androidx.room.Database
import androidx.room.Room
import androidx.room.RoomDatabase
import com.geocdias.convecurrency.data.database.dao.CurrencyDao
import com.geocdias.convecurrency.data.database.dao.ExchangeRateDao
import com.geocdias.convecurrency.data.database.entities.CurrencyEntity
import com.geocdias.convecurrency.data.database.entities.ExchangeRateEntity

@Database(entities = [CurrencyEntity::class, ExchangeRateEntity::class ], version = 1)
abstract class CurrencyDatabase : RoomDatabase() {
    abstract fun currencyDao(): CurrencyDao
    abstract fun exchangeRateDao(): ExchangeRateDao

    companion object {
        @Volatile private var instance: CurrencyDatabase? = null

        fun getDatabase(context: Context): CurrencyDatabase =
            instance ?: synchronized(this) {
                instance ?: buildDatabase(context).also { instance = it }
            }

        private fun buildDatabase(context: Context): CurrencyDatabase {
            return Room.databaseBuilder(context, CurrencyDatabase::class.java, "currency_db")
                .fallbackToDestructiveMigration()
                .build()
        }
    }
}
