package br.com.btg.btgchallenge.network.api.currencylayer

import android.content.Context
import br.com.btg.btgchallenge.network.api.config.Resource
import br.com.btg.btgchallenge.network.model.currency.Currencies
import br.com.btg.btgchallenge.network.model.currency.Quotes
import br.com.btg.btgchallenge.network.room.dao.CurrencyDao
import br.com.btg.btgchallenge.network.room.dao.CurrencyRoom
import java.lang.Exception

class CurrencyRepositoryLocal(private val context: Context) {

    suspend fun getCurrencies(): Currencies? {
        return try {
            val currencies = CurrencyRoom.getCurrencies(context)
            return currencies
        } catch (e: Exception) {
            return null
        }
    }

    suspend fun getQuotes(): Quotes? {
        return try {
            val quotes = CurrencyRoom.getQuotes(context)
            if(quotes != null)
            {
                if(!checkInfoIsUpdated(quotes.lastUpdate, 3600))
                {
                    return null
                }
            }
            return quotes
        } catch (e: Exception) {
            return null
        }
    }

    suspend fun insertCurrencies(currencies: Currencies) {
        return try {
            CurrencyRoom.insertCurrencies(currencies, context)
        } catch (e: Exception) {
        }
    }

    suspend fun insertQuotes(quotes: Quotes) {
        return try {
            CurrencyRoom.insertQuotes(quotes, context)
        } catch (e: Exception) {
        }
    }

    fun checkInfoIsUpdated(lastUpdate: Int?, maxTime: Long) : Boolean
    {
        if(lastUpdate == null || lastUpdate == 0 || lastUpdate > maxTime)
        {
            return false
        }
        return true
    }
}