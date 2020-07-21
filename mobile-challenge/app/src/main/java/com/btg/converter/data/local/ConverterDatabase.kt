package com.btg.converter.data.local

import android.content.Context
import androidx.room.Database
import androidx.room.Room
import androidx.room.RoomDatabase
import com.btg.converter.BuildConfig
import com.btg.converter.data.local.dao.CurrencyDao
import com.btg.converter.data.local.dao.QuoteDao
import com.btg.converter.data.local.entity.DbCurrency
import com.btg.converter.data.local.entity.DbQuote

@Database(entities = [DbCurrency::class, DbQuote::class], version = 1, exportSchema = false)
abstract class ConverterDatabase : RoomDatabase() {

    abstract fun currencyDao(): CurrencyDao
    abstract fun quoteDao(): QuoteDao

    companion object {
        fun build(context: Context): ConverterDatabase {
            return Room.databaseBuilder(
                context,
                ConverterDatabase::class.java,
                BuildConfig.DATABASE_NAME
            ).build()
        }
    }
}