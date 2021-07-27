package com.alexandreac.mobilechallenge.model.database

import androidx.room.Database
import androidx.room.RoomDatabase
import com.alexandreac.mobilechallenge.model.data.Currency
import com.alexandreac.mobilechallenge.model.dao.CurrencyDao

@Database(entities = arrayOf(Currency::class), version = 1)
abstract class AppDatabase : RoomDatabase() {
    abstract fun currencyDao(): CurrencyDao
}