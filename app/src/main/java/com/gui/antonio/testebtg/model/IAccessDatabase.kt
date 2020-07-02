package com.gui.antonio.testebtg.model

import com.gui.antonio.testebtg.data.Currencies
import com.gui.antonio.testebtg.data.Quotes

interface IAccessDatabase {
    fun getCurrencies(): List<Currencies>
    fun insertCurrencies(currenciesData: List<Currencies>)
    fun deleteCurrencies()
    fun getQuote(symbol: String): Quotes
    fun insertQuotes(quotes: List<Quotes>)
    fun deleteQuotes()
}