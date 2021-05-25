package com.vald3nir.data.database

import androidx.room.Database
import androidx.room.RoomDatabase
import com.vald3nir.data.database.dao.CurrencyDao
import com.vald3nir.data.database.dao.CurrencyViewDao
import com.vald3nir.data.database.dao.ExchangeDao
import com.vald3nir.data.database.dao.FlagDao
import com.vald3nir.data.database.model.Currency
import com.vald3nir.data.database.model.Exchange
import com.vald3nir.data.database.model.Flag

@Database(
    entities = [Currency::class, Exchange::class, Flag::class],
    version = 1, exportSchema = false
)
abstract class AppDatabase : RoomDatabase() {
    abstract fun FlagDao(): FlagDao
    abstract fun CurrencyDao(): CurrencyDao
    abstract fun currencyViewDao(): CurrencyViewDao
    abstract fun ExchangeDao(): ExchangeDao
}