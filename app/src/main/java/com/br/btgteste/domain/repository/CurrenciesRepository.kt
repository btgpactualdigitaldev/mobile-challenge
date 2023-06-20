package com.br.btgteste.domain.repository

import com.br.btgteste.data.model.CurrencyListDTO
import com.br.btgteste.data.model.CurrencyLiveDTO

interface CurrenciesRepository {
    suspend fun getCurrencies() : CurrencyListDTO
    suspend fun convertCurrencies() : CurrencyLiveDTO
}