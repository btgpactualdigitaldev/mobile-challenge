package com.br.cambio.data.local.datasource

import com.br.cambio.data.model.Currency
import com.br.cambio.data.model.Price
import com.br.cambio.domain.model.CurrencyDomain
import com.br.cambio.domain.model.PriceDomain

interface LocalDataSource {
    suspend fun getCurrencies(): List<CurrencyDomain>?

    suspend fun getPrices(): List<PriceDomain>?

    suspend fun insertCurrencies(currency: List<CurrencyDomain>)

    suspend fun insertPrices(price: List<PriceDomain>)
}