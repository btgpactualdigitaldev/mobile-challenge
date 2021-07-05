package com.example.currencyconverter.database

import androidx.room.Database
import androidx.room.RoomDatabase

@Database(entities = [CurrencyModel::class], version = 1)
abstract class CurrencyDatabase: RoomDatabase() {

    abstract fun currencyDao(): CurrencyDao
}