package com.romildosf.currencyconverter.datasource

import com.romildosf.currencyconverter.dao.Currency
import com.romildosf.currencyconverter.dao.Quotation

interface RemoteCurrencyDataSource {
    suspend fun fetchCurrencies(): List<Currency>
    suspend fun fetchQuotes(): List<Quotation>
}