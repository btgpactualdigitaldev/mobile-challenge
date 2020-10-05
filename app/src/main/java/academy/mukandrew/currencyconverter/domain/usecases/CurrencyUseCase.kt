package academy.mukandrew.currencyconverter.domain.usecases

import academy.mukandrew.currencyconverter.commons.Result
import academy.mukandrew.currencyconverter.domain.models.Currency
import academy.mukandrew.currencyconverter.domain.models.CurrencyQuote

abstract class CurrencyUseCase {
    abstract suspend fun list(): Result<List<Currency>>
    abstract fun getQuoteByCode(currencyCode: String, quotes: List<CurrencyQuote>): CurrencyQuote?
    abstract suspend fun convert(
        quantity: Float,
        fromCurrency: Currency,
        toCurrency: Currency
    ): Result<Float>
}