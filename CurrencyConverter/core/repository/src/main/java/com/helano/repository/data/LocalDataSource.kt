package com.helano.repository.data

import com.helano.database.dao.CurrencyDao
import com.helano.database.dao.CurrencyQuoteDao
import com.helano.shared.model.Currency
import com.helano.shared.model.CurrencyQuote
import javax.inject.Inject

class LocalDataSource @Inject constructor(
    private val currencyDao: CurrencyDao,
    private val currencyQuoteDao: CurrencyQuoteDao
) {

    var currencies: List<Currency>
        get() = currencyDao.getAll()
        set(value) = currencyDao.insertAll(value)

    var currenciesQuotes: List<CurrencyQuote>
        get() = currencyQuoteDao.getAll()
        set(value) = currencyQuoteDao.insertAll(value)

    fun deleteAllCurrencies() {
        currencyDao.deleteAll()
    }

    fun deleteAllCurrenciesQuotes() {
        currencyQuoteDao.deleteAll()
    }

    fun getCurrency(code: String): Currency {
        return currencyDao.getCurrency(code)
    }

    fun getCurrencyQuote(code: String): CurrencyQuote {
        return currencyQuoteDao.getCurrency(code)
    }
}