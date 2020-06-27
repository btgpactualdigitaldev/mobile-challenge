package com.btg.converter.domain.boundary

import com.btg.converter.domain.entity.currency.CurrencyList

interface CurrencyRepository {

    suspend fun getCurrencyList(): CurrencyList?
}