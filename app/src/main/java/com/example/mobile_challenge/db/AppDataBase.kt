package com.example.mobile_challenge.db

import androidx.room.Database
import androidx.room.RoomDatabase
import com.example.mobile_challenge.model.CurrencyEntity
import com.example.mobile_challenge.model.QuoteEntity

@Database(entities = [
  QuoteEntity::class,
  CurrencyEntity::class
], version = 1)
abstract class AppDatabase : RoomDatabase() {
  abstract fun currencyDao(): CurrencyDao
  abstract fun quoteDao(): QuoteDao
}