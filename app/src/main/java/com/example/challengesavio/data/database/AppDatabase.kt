package com.example.challengesavio.data.database

import androidx.room.Database
import androidx.room.RoomDatabase
import com.example.challengesavio.data.entity.Currency
import com.example.challengesavio.data.entity.Quote
import com.example.roomdatabase.dao.CurrencyDao
import com.example.roomdatabase.dao.CurrencyQuoteDao

@Database(version = 1, entities = arrayOf(Currency::class, Quote::class))
abstract class AppDatabase : RoomDatabase() {

    abstract fun currencyDao() : CurrencyDao

    abstract fun currencyQuoteDao() : CurrencyQuoteDao
}