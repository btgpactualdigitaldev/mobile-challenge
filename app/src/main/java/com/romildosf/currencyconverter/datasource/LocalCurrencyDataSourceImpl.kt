package com.romildosf.currencyconverter.datasource

import com.romildosf.currencyconverter.dao.CurrencyDao
import com.romildosf.currencyconverter.dao.Currency
import com.romildosf.currencyconverter.dao.Quotation
import com.romildosf.currencyconverter.dao.QuotationDao

class LocalCurrencyDataSourceImpl(private val dao: CurrencyDao, private val quotationDao: QuotationDao): LocalCurrencyDataSource {

    override suspend fun insertCurrency(currency: Currency) {
        dao.insert(listOf(currency))
    }

    override suspend fun getCurrencies(): List<Currency> {
        return dao.getAll()
    }

    override suspend fun insertCurrencies(currencies: List<Currency>) {
        dao.insert(currencies)
    }

    override suspend fun getCurrency(symbol: String): Currency {
        return dao.get(symbol)
    }

    override suspend fun getQuotation(pair: String): Quotation {
        return quotationDao.get(pair)
    }

    override suspend fun insertQuotation(quotation: Quotation) {
        quotationDao.insert(listOf(quotation))
    }

    override suspend fun getQuotes(): List<Quotation> {
        return quotationDao.getAll()
    }

    override suspend fun insertQuotes(quotes: List<Quotation>) {
        quotationDao.insert(quotes)
    }

    override suspend fun deleteCurrencies(currencies: List<Currency>) {
        dao.delete(currencies)
    }

    override suspend fun updateCurrencies(currencies: List<Currency>) {
        dao.update(currencies)
    }

    override suspend fun deleteQuotes(quotes: List<Quotation>) {
        quotationDao.delete(quotes)
    }

    override suspend fun updateQuotes(quotes: List<Quotation>) {
        quotationDao.update(quotes)
    }
}