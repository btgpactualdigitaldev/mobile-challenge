package com.helano.repository

import com.helano.shared.model.Currency
import com.helano.shared.model.CurrencyQuote

interface CurrencyRepository {

    suspend fun refreshData(): Long?

    suspend fun currencies(): List<Currency>

    suspend fun getCurrency(code: String): Currency

    suspend fun getCurrencyQuote(code: String): CurrencyQuote
}