package com.btg.convertercurrency.data_local.database

import android.content.Context
import androidx.room.Database
import androidx.room.Room
import androidx.room.RoomDatabase
import androidx.room.TypeConverters
import androidx.sqlite.db.SupportSQLiteDatabase
import com.btg.convertercurrency.data_local.dao.CurrencyDao
import com.btg.convertercurrency.data_local.dao.QuoteDao
import com.btg.convertercurrency.data_local.dao.SettingsDao
import com.btg.convertercurrency.data_local.entity.CurrencyDb
import com.btg.convertercurrency.data_local.entity.QuoteDb
import com.btg.convertercurrency.data_local.entity.SettingsDb
import com.btg.convertercurrency.data_local.entity.converters.DataTypeConverters
import java.util.*

@Database(
    entities = [CurrencyDb::class,SettingsDb::class, QuoteDb::class],
    version = 1,
    exportSchema = false)
@TypeConverters(DataTypeConverters::class)
abstract class AppDatabase : RoomDatabase() {

    abstract fun currencyDao(): CurrencyDao
    abstract fun settingsDao(): SettingsDao
    abstract fun quoteDao(): QuoteDao

    companion object {

        // For Singleton instantiation
        @Volatile
        private var instance: AppDatabase? = null

        fun getInstance(context: Context): AppDatabase {
            return instance ?: synchronized(this) {
                instance ?: buildDatabase(context).also { instance = it }
            }
        }

        private fun buildDatabase(context: Context): AppDatabase {
            return Room.databaseBuilder(context, AppDatabase::class.java, "btg_data_base2")
                .fallbackToDestructiveMigration()
                .addCallback(object : RoomDatabase.Callback() {
                    override fun onCreate(db: SupportSQLiteDatabase) {
                        super.onCreate(db)

                        SettingsDb.getUpdated().key

                        //pre-populate data
                        val dateStr = Date().toString()
                        val sqlInsert = "INSERT INTO SettingsDb VALUES('%s', '%s','%s');"

                        db.execSQL(
                            String.format(sqlInsert,SettingsDb.getUpdated().key,SettingsDb.getUpdated().value,dateStr)
                        )

                        db.execSQL(
                            String.format(sqlInsert,SettingsDb.getFromCurrency().key,SettingsDb.getFromCurrency().value,dateStr)
                        )

                        db.execSQL(
                            String.format(sqlInsert,SettingsDb.getToCurrency().key,SettingsDb.getToCurrency().value,dateStr)
                        )
                    }
                })
                .build()
        }
    }
}