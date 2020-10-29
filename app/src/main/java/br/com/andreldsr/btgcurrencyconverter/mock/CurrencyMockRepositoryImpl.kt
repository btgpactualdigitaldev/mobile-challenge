package br.com.andreldsr.btgcurrencyconverter.mock

import br.com.andreldsr.btgcurrencyconverter.domain.entities.Currency
import br.com.andreldsr.btgcurrencyconverter.domain.repositories.CurrencyRepository

class CurrencyMockRepositoryImpl() : CurrencyRepository {
    override suspend fun getCurrency(): List<Currency> {
        val currencies = mutableListOf<Currency>()
        val currenciesMap = mapOf(
            "AED" to "United Arab Emirates Dirham",
            "CAD" to "Canadian Dollar",
            "BRL" to "Brazilian Real",
            "USD" to "United States Dollar"
        )
        currenciesMap.map {
            currencies.add(Currency(initials = it.key, name = it.value))
        }
        return currencies
    }

    override suspend fun getQuote(from: String, to: String): Float {
        val quoteMap =
            mapOf("USDUSD" to 1f, "USDBRL" to 5.63f, "USDCAD" to 1.32f, "USDAED" to 3.62f)
        val quoteFrom = quoteMap["${baseQuoteName}$from"] ?: throw Exception()
        val quoteTo = quoteMap["${baseQuoteName}$to"] ?: throw Exception()
        return quoteTo / quoteFrom;
    }

    override suspend fun getQuoteList(): Map<String, String> {
        return mapOf()
    }

    companion object {
        const val baseQuoteName = "USD"
        fun build(): CurrencyMockRepositoryImpl {
            return CurrencyMockRepositoryImpl()
        }
    }
}