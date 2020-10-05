package academy.mukandrew.currencyconverter.domain.repositories

import academy.mukandrew.currencyconverter.commons.Result
import academy.mukandrew.currencyconverter.domain.models.Currency
import academy.mukandrew.currencyconverter.domain.models.CurrencyQuote

abstract class CurrencyRepository {
    abstract suspend fun list(): Result<List<Currency>>
    abstract suspend fun assembleCurrencyList(currencyMap: Map<String, String>): List<Currency>
    abstract suspend fun quotes(): Result<List<CurrencyQuote>>
    abstract suspend fun assembleQuoteList(quoteMap: Map<String, Float>): List<CurrencyQuote>
}