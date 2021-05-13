package br.com.btg.btgchallenge.network.room

import android.content.Context
import androidx.room.Database
import androidx.room.Room
import androidx.room.RoomDatabase
import androidx.room.TypeConverters
import br.com.btg.btgchallenge.network.model.currency.Currencies
import br.com.btg.btgchallenge.network.model.currency.Quotes
import br.com.btg.btgchallenge.network.room.dao.CurrencyDao

// Annotates class to be a Room Database with a table (entity) of the Word class
@Database(entities = arrayOf(
    Currencies::class,
    Quotes::class), version = 1, exportSchema = false)
@TypeConverters(Converters::class)
public abstract class CurrConversionRoomDatabase : RoomDatabase() {

    abstract fun currencyDao(): CurrencyDao

    companion object {
        // Singleton prevents multiple instances of database opening at the
        // same time.
        @Volatile
        private var INSTANCE: CurrConversionRoomDatabase? = null

        fun getDatabase(context: Context): CurrConversionRoomDatabase {
            val tempInstance = INSTANCE
            if (tempInstance != null) {
                return tempInstance
            }
            synchronized(this) {
                val instance = Room.databaseBuilder(
                    context.applicationContext,
                    CurrConversionRoomDatabase::class.java,
                    "currency_conversion_database"
                ).build()
                INSTANCE = instance
                return instance
            }
        }
    }
}