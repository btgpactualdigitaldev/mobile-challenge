package br.com.btg.btgchallenge.network.room.dao

import android.content.Context
import br.com.btg.btgchallenge.network.model.currency.Currencies
import br.com.btg.btgchallenge.network.model.currency.Quotes
import br.com.btg.btgchallenge.network.room.CurrConversionRoomDatabase

open class CurrencyRoom {

    companion object {

        suspend fun insertQuotes(quotes: Quotes, context: Context)
        {
            val currencyDao = CurrConversionRoomDatabase.getDatabase(context).currencyDao()
            currencyDao.insertQuotes(quotes)
        }

        suspend fun insertCurrencies(currencies: Currencies, context: Context)
        {
            val currencyDao = CurrConversionRoomDatabase.getDatabase(context).currencyDao()
            currencyDao.insertCurrencies(currencies)
        }

        suspend fun getQuotes(context: Context) : Quotes?
        {
            val currencyDao = CurrConversionRoomDatabase.getDatabase(context).currencyDao()
            val quotes = currencyDao.getQuotes()
            return quotes
        }

        suspend fun getCurrencies(context: Context) : Currencies?
        {
            val currencyDao = CurrConversionRoomDatabase.getDatabase(context).currencyDao()
            val currencies = currencyDao.getCurrencies()
            return currencies
        }

        suspend fun deleteCurrencies(context: Context){
            val currencyDao = CurrConversionRoomDatabase.getDatabase(context).currencyDao()
            currencyDao.deleteCurrencies()
        }

        suspend fun deleteQuotes(context: Context){
            val currencyDao = CurrConversionRoomDatabase.getDatabase(context).currencyDao()
            currencyDao.deleteQuotes()
        }
    }
}