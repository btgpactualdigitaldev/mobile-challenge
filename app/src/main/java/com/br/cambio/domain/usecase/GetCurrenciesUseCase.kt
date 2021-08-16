package com.br.cambio.domain.usecase

import com.br.cambio.domain.repository.CurrencyRepository

class GetCurrenciesUseCase(
    private val repository: CurrencyRepository
) {
    suspend operator fun invoke(network: Boolean) = repository.getCurrencies(network)
}