package com.romildosf.currencyconverter.dao

import androidx.room.Database
import androidx.room.RoomDatabase

@Database(entities = [Currency::class, Quotation::class], version = 1, exportSchema=false)
abstract class AppDatabase: RoomDatabase() {
    abstract fun currencyDao(): CurrencyDao
    abstract fun quotationDao(): QuotationDao
}