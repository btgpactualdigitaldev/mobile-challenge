package br.com.andreldsr.btgcurrencyconverter.data.db

import android.content.Context
import androidx.room.Database
import androidx.room.Room
import androidx.room.RoomDatabase
import br.com.andreldsr.btgcurrencyconverter.data.dao.CurrencyDAO
import br.com.andreldsr.btgcurrencyconverter.data.model.CurrencyEntity

@Database(entities = [CurrencyEntity::class], version = 1)
abstract class AppDatabase : RoomDatabase() {
    abstract val currencyDao: CurrencyDAO

    companion object {
        @Volatile
        private var INSTANCE: AppDatabase? = null
        fun getInstance(context: Context): AppDatabase {
            synchronized(this) {
                var instance: AppDatabase? = INSTANCE
                if (instance == null) {
                    instance = Room.databaseBuilder(
                        context,
                        AppDatabase::class.java,
                        "appDatabase"
                    ).build()
                }
                return instance
            }
        }
    }
}