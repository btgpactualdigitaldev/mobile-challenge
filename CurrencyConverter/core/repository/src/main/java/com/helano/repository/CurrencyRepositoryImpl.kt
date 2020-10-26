package com.helano.repository

import com.helano.repository.data.LocalDataSource
import com.helano.repository.data.RemoteDataSource
import com.helano.shared.model.Currency
import com.helano.shared.model.CurrencyQuote

class CurrencyRepositoryImpl(
    private val local: LocalDataSource,
    private val remote: RemoteDataSource
) : CurrencyRepository {

    override suspend fun refreshData(): Long? {
        val currencies = remote.currencies()
        if (currencies.success) {
            local.deleteAllCurrencies()
            local.currencies = currencies.currencies.map { Currency(it.key, it.value) }
        }

        val quotes = remote.quotes()
        return if (quotes.success) {
            local.deleteAllCurrenciesQuotes()
            local.currenciesQuotes = quotes.quotes.map { CurrencyQuote(it.key, it.value) }
            quotes.timestamp
        } else {
            null
        }
    }

    override suspend fun currencies(): List<Currency> {
        return local.currencies
    }

    override suspend fun getCurrency(code: String): Currency {
        return local.getCurrency(code)
    }

    override suspend fun getCurrencyQuote(code: String): CurrencyQuote {
        return local.getCurrencyQuote(code)
    }
}