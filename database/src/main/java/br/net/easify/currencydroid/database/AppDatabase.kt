package br.net.easify.currencydroid.database

import android.content.Context
import androidx.room.Database
import androidx.room.Room
import androidx.room.RoomDatabase
import br.net.easify.currencydroid.database.dao.CurrencyDao
import br.net.easify.currencydroid.database.dao.QuoteDao
import br.net.easify.currencydroid.database.model.Currency
import br.net.easify.currencydroid.database.model.Quote

@Database(
    entities = [
        Currency::class,
        Quote::class
    ],
    version = 1,
    exportSchema = false
)
abstract class AppDatabase : RoomDatabase() {
    abstract fun currencyDao(): CurrencyDao
    abstract fun quoteDao(): QuoteDao

    companion object {
        private var instance: AppDatabase? = null
        private var databaseName = "currencydroid.sqlite"

        fun getAppDataBase(context: Context): AppDatabase {
            if (instance == null) {
                synchronized(AppDatabase::class) {
                    instance = Room.databaseBuilder(
                        context,
                        AppDatabase::class.java,
                        databaseName)
                        .allowMainThreadQueries()
                        .build()
                }
            }
            return instance!!
        }
    }
}