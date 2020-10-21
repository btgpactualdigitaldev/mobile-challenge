package com.romildosf.currencyconverter.repository

import com.romildosf.currencyconverter.dao.Currency
import com.romildosf.currencyconverter.dao.Quotation
import com.romildosf.currencyconverter.util.Result

interface CurrencyRepository {

    suspend fun fetchCurrencyList(): Result<List<Currency>>
    suspend fun fetchCurrencyQuotation(source: String, target: String): Result<Quotation>

}