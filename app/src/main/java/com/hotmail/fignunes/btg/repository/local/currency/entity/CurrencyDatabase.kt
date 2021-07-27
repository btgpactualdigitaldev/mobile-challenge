package com.hotmail.fignunes.btg.repository.local.currency.entity

import androidx.room.Database
import androidx.room.RoomDatabase

@Database(entities = [(CurrencyBean::class)], version = 1)

abstract class CurrencyDatabase : RoomDatabase() {
    abstract fun currencyDao(): CurrencyDao
}