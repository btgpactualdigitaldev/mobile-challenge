package com.br.cambio.domain.usecase

import com.br.cambio.domain.repository.PricesRepository

class GetPricesUseCase(
    private val repository: PricesRepository
) {
    suspend operator fun invoke(network: Boolean) = repository.getPrices(network)
}