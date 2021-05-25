package br.com.btg.test.data

import androidx.room.Database
import androidx.room.RoomDatabase
import br.com.btg.test.feature.currency.persistence.CurrencyDao
import br.com.btg.test.feature.currency.persistence.CurrencyEntity

const val DATABASE_NAME = "currency-dfb"
@Database
    (entities = [CurrencyEntity::class], version = 1)
abstract class AppDatabase : RoomDatabase() {
    abstract fun currencyDao(): CurrencyDao
}