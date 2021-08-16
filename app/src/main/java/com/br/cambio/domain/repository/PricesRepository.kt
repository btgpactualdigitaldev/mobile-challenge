package com.br.cambio.domain.repository

import com.br.cambio.presentation.mapper.QuotaPresentation

interface PricesRepository {
    suspend fun getPrices(network: Boolean): QuotaPresentation
}