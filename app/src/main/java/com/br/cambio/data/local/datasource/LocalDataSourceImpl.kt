package com.br.cambio.data.local.datasource

import android.util.Log
import com.br.cambio.data.api.Api
import com.br.cambio.data.local.AppDatabase
import com.br.cambio.data.mapper.CurrencyToDomainMapper
import com.br.cambio.data.mapper.PriceToDomainMapper
import com.br.cambio.data.model.Currency
import com.br.cambio.data.model.Price
import com.br.cambio.domain.model.CurrencyDomain
import com.br.cambio.domain.model.PriceDomain

class LocalDataSourceImpl(
    private val local: AppDatabase
) : LocalDataSource {

    override suspend fun getCurrencies(): List<CurrencyDomain>? {
        val response = local.currencyDao().getCurrencyList()

        return if (response.isNotEmpty()) {
            local.currencyDao().getCurrencyList()
        } else {
            null
        }
    }

    override suspend fun getPrices(): List<PriceDomain>? {
        val response = local.priceDao().getPriceList()

        return if (response.isNotEmpty()) {
            local.priceDao().getPriceList()
        } else {
            null
        }
    }

    override suspend fun insertCurrencies(currency: List<CurrencyDomain>) {
        local.currencyDao().insertCurrencyList(currency)
    }

    override suspend fun insertPrices(price: List<PriceDomain>) {
        local.priceDao().insertPriceList(price)
    }
}