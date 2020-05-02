package io.felipeandrade.currencylayertest.usecase

import io.felipeandrade.data.CurrencyRepository
import java.math.BigDecimal
import java.math.RoundingMode

class ConvertUseCase(private val currencyRepository: CurrencyRepository) {

    private val USD_CODE = "USD"

    suspend operator fun invoke(origin: String, target: String, value: BigDecimal): BigDecimal {
        val originQuotes = currencyRepository.loadLiveCurrencies(USD_CODE, origin, target)
        val originFactor = originQuotes[origin]?.factor ?: throw Exception("origin quota not found")
        val targetFactor = originQuotes[target]?.factor ?: throw Exception("target quota not found")

        return (value * targetFactor / originFactor).setScale(2, RoundingMode.HALF_EVEN)
    }
}