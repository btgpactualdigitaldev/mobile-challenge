package com.btg.converter.data.repository

import com.btg.converter.data.local.dao.CurrencyDao
import com.btg.converter.data.local.entity.DbCurrency
import com.btg.converter.data.remote.client.ApiClient
import com.btg.converter.data.util.request.handleException
import com.btg.converter.domain.boundary.CurrencyRepository
import com.btg.converter.domain.entity.currency.Currency
import com.btg.converter.domain.entity.currency.CurrencyList
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.withContext

class DefaultCurrencyRepository constructor(
    private val apiClient: ApiClient,
    private val currencyDao: CurrencyDao
) : CurrencyRepository {

    override suspend fun getCurrencyList(): CurrencyList? {
        return handleException(::getFromDatabase) {
            apiClient.getCurrencyList()?.toDomainObject()
                ?.also { saveCurrenciesIntoDatabase(it.currencies) }
        }
    }

    private suspend fun getFromDatabase(e: Throwable): CurrencyList? {
        val currencyList = currencyDao.getCurrencies()
        if (currencyList.isNotEmpty()) {
            return CurrencyList(true, currencyList.map { it.toDomainObject() })
        } else {
            throw e
        }
    }

    private suspend fun saveCurrenciesIntoDatabase(currencies: List<Currency>) {
        withContext(Dispatchers.IO) {
            currencyDao.insertCurrencies(currencies.map { DbCurrency.fromDomainObject(it) })
        }
    }
}