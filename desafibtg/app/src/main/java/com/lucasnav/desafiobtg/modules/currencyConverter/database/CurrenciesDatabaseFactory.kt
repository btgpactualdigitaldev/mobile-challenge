package com.lucasnav.desafiobtg.modules.currencyConverter.database

import android.content.Context
import androidx.room.Database
import androidx.room.Room
import androidx.room.RoomDatabase
import com.lucasnav.desafiobtg.modules.currencyConverter.model.Currency
import com.lucasnav.desafiobtg.modules.currencyConverter.model.Quote

@Database(entities = [Quote::class, Currency::class], version = 1)
abstract class CurrenciesDatabaseFactory : RoomDatabase() {

    abstract fun currenciesDao(): CurrenciesDao
    abstract fun quotesDao(): QuotesDao

    companion object {

        fun create(context: Context): CurrenciesDatabaseFactory {

            return Room.databaseBuilder(
                context,
                CurrenciesDatabaseFactory::class.java,
                "currenciesDb"
            )
                .build()
        }
    }
}