package academy.mukandrew.currencyconverter.data.local.room

import academy.mukandrew.currencyconverter.data.local.daos.CurrencyDao
import academy.mukandrew.currencyconverter.data.local.daos.CurrencyQuoteDao
import academy.mukandrew.currencyconverter.data.local.entities.CurrencyEntity
import academy.mukandrew.currencyconverter.data.local.entities.CurrencyQuoteEntity
import android.content.Context
import androidx.room.Database
import androidx.room.Room
import androidx.room.RoomDatabase

@Database(
    entities = [
        CurrencyEntity::class,
        CurrencyQuoteEntity::class
    ],
    version = 1
)
abstract class AppDatabase : RoomDatabase() {
    abstract fun currencyDao(): CurrencyDao
    abstract fun currencyQuoteDao(): CurrencyQuoteDao

    companion object {
        fun createDatabase(context: Context): AppDatabase {
            return Room
                .databaseBuilder(
                    context,
                    AppDatabase::class.java,
                    "MobileChallengeDatabaseName"
                ).build()
        }
    }
}