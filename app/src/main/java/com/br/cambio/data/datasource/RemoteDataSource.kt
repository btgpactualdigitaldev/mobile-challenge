package com.br.cambio.data.datasource

import com.br.cambio.domain.model.CurrencyDomain
import com.br.cambio.domain.model.PriceDomain

interface RemoteDataSource {
    suspend fun getCurrencies(): List<CurrencyDomain>?

    suspend fun getPrices(): List<PriceDomain>?
}