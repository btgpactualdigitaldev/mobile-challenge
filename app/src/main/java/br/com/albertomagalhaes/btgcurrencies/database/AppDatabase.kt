package br.com.albertomagalhaes.btgcurrencies.database

import android.content.Context
import androidx.room.Database
import androidx.room.Room
import androidx.room.RoomDatabase
import br.com.albertomagalhaes.btgcurrencies.dao.CurrencyDAO
import br.com.albertomagalhaes.btgcurrencies.dto.CurrencyDTO

@Database(
    entities = [
        CurrencyDTO::class
    ],
    version = 1
)
abstract class AppDatabase : RoomDatabase() {

    abstract val currencyDAO: CurrencyDAO

    companion object {
        @Volatile
        private var INSTANCE: AppDatabase? = null

        fun getInstance(context: Context): AppDatabase {
            synchronized(this) {
                var instance: AppDatabase? =
                    INSTANCE
                if (instance == null) {
                    instance = Room.databaseBuilder(
                        context,
                        AppDatabase::class.java,
                        "btg_currencies_db"
                    ).build()
                }

                return instance
            }
        }
    }
}