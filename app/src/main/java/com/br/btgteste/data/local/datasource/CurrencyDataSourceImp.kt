package com.br.btgteste.data.local.datasource

import com.br.btgteste.data.local.db.CurrencyDao
import com.br.btgteste.data.mapper.BusinessMapper
import com.br.btgteste.domain.datasource.CurrencyDataSource
import com.br.btgteste.domain.model.Currency

class CurrencyDataSourceImp(private val currencyDao: CurrencyDao): CurrencyDataSource {

    override fun getCurrencies(): List<Currency> = BusinessMapper.convertCurrencyDbToCurrency(
        currencyDao.retrieve())

    override suspend fun updateCurrencies(currencies: List<Currency>) {
        currencyDao.deleteAll()
        currencyDao.save(BusinessMapper.convertCurrencyToCurrencyDb(currencies))
    }
}