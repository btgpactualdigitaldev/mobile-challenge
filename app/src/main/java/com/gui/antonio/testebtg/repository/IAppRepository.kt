package com.gui.antonio.testebtg.repository

import androidx.lifecycle.LiveData
import com.gui.antonio.testebtg.data.Currencies
import com.gui.antonio.testebtg.data.Quotes

interface IAppRepository {
    fun getListCurrency() : LiveData<List<Currencies>>
    fun getListCurrencyOffline(): LiveData<List<Currencies>>
    fun getQuote(symbol: String) : LiveData<Quotes>
    fun deleteAndInsertQuotes(symbol: List<String>)
    fun getQuoteOffline(symbol: String): LiveData<Quotes>

}