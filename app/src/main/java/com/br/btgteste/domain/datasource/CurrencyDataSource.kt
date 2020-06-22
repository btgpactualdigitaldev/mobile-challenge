package com.br.btgteste.domain.datasource

import com.br.btgteste.domain.model.Currency

interface CurrencyDataSource {
    fun getCurrencies() : List<Currency>
    suspend fun updateCurrencies(currencies: List<Currency>)
}