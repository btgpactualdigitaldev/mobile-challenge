package io.felipeandrade.data

import io.felipeandrade.data.api.CurrencyApi
import io.felipeandrade.data.mapper.CurrencyMapper
import io.felipeandrade.domain.CurrencyModel
import io.felipeandrade.domain.QuoteModel

class CurrencyRepository(
    private val currencyApi: CurrencyApi,
    private val currencyMapper: CurrencyMapper
) {
    suspend fun loadSupportedCurrencies(): List<CurrencyModel> {
        val response = currencyApi.loadSupportedCurrencies(BuildConfig.API_KEY)
        return currencyMapper.mapSupportedCurrencies(response)
    }

    suspend fun loadLiveCurrencies(
        usd: String,
        origin: String,
        target: String
    ): Map<String, QuoteModel> {
        val response = currencyApi.loadLiveCurrencies(
            apiKey = BuildConfig.API_KEY,
            source = usd,
            currency = "$origin,$target"
        )
        return currencyMapper.mapLiveCurrency(response)
    }

}


