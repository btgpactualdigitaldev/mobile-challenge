package academy.mukandrew.currencyconverter.data.datasources

import academy.mukandrew.currencyconverter.commons.Result

abstract class CurrencyDataSource {
    abstract suspend fun list(): Result<Map<String, String>>
    open suspend fun saveCurrencies(currencies: Map<String, String>) = Unit
    abstract suspend fun quotes(): Result<Map<String, Float>>
    open suspend fun saveQuotes(quotes: Map<String, Float>) = Unit
}