package com.btgpactual.currencyconverter.data.framework.roomdatabase

import android.content.Context
import androidx.room.Database
import androidx.room.Room
import androidx.room.RoomDatabase
import com.btgpactual.currencyconverter.data.framework.roomdatabase.dao.ConversionDAO
import com.btgpactual.currencyconverter.data.framework.roomdatabase.dao.CurrencyDAO
import com.btgpactual.currencyconverter.data.framework.roomdatabase.entity.ConversionEntity
import com.btgpactual.currencyconverter.data.framework.roomdatabase.entity.CurrencyEntity

@Database(
    entities = [
        ConversionEntity::class,
        CurrencyEntity::class
    ],
    version = 1
)
abstract class AppDatabase : RoomDatabase() {

    abstract val conversionDAO: ConversionDAO
    abstract val currencyDAO: CurrencyDAO

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
                        "app_database"
                    ).build()
                }

                return instance
            }
        }
    }
}