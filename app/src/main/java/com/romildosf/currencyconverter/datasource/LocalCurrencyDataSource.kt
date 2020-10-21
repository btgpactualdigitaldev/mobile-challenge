package com.romildosf.currencyconverter.datasource

import com.romildosf.currencyconverter.dao.Currency
import com.romildosf.currencyconverter.dao.Quotation

interface LocalCurrencyDataSource {
    suspend fun getCurrency(symbol: String): Currency
    suspend fun insertCurrency(currencies: Currency)
    suspend fun getCurrencies(): List<Currency>
    suspend fun insertCurrencies(currencies: List<Currency>)
    suspend fun deleteCurrencies(currencies: List<Currency>)
    suspend fun updateCurrencies(currencies: List<Currency>)

    suspend fun getQuotation(pair: String): Quotation
    suspend fun insertQuotation(quotation: Quotation)
    suspend fun getQuotes(): List<Quotation>
    suspend fun insertQuotes(quotes: List<Quotation>)
    suspend fun deleteQuotes(quotes: List<Quotation>)
    suspend fun updateQuotes(quotes: List<Quotation>)
}