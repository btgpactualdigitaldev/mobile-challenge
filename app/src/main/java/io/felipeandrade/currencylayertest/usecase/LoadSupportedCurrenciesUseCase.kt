package io.felipeandrade.currencylayertest.usecase

import io.felipeandrade.data.CurrencyRepository
import io.felipeandrade.domain.CurrencyModel

class LoadSupportedCurrenciesUseCase(private val currencyRepository: CurrencyRepository) {
    suspend operator fun invoke(): List<CurrencyModel> = currencyRepository.loadSupportedCurrencies()
}