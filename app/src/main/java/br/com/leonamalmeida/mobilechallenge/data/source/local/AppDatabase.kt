package br.com.leonamalmeida.mobilechallenge.data.source.local

import androidx.room.Database
import androidx.room.RoomDatabase
import br.com.leonamalmeida.mobilechallenge.data.Currency
import br.com.leonamalmeida.mobilechallenge.data.Rate
import br.com.leonamalmeida.mobilechallenge.data.source.local.dao.CurrencyDao
import br.com.leonamalmeida.mobilechallenge.data.source.local.dao.RateDao

/**
 * Created by Leo Almeida on 27/06/20.
 */

private const val DATABASE_VERSION = 1

@Database(entities = [Currency::class, Rate::class], version = DATABASE_VERSION)
abstract class AppDatabase : RoomDatabase() {

    abstract fun currencyDao(): CurrencyDao

    abstract fun rateDao(): RateDao
}