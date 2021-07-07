package leandro.com.leandroteste.model.dao

import androidx.room.Database
import androidx.room.RoomDatabase
import leandro.com.leandroteste.model.dao.CurrencyDao
import leandro.com.leandroteste.model.data.Currency

@Database(entities = arrayOf(Currency::class), version = 1)
abstract class AppDatabase : RoomDatabase() {
    abstract fun currencyDao(): CurrencyDao
}