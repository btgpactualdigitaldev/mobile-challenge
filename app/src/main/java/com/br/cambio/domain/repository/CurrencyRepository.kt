package com.br.cambio.domain.repository

import com.br.cambio.presentation.mapper.ExchangePresentation

interface CurrencyRepository {
    suspend fun getCurrencies(network: Boolean): ExchangePresentation
}