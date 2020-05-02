package io.felipeandrade.data.mapper

import io.felipeandrade.data.api.response.LiveCurrenciesResponse
import io.felipeandrade.data.api.response.SupportedCurrenciesResponse
import io.felipeandrade.domain.CurrencyModel
import io.felipeandrade.domain.QuoteModel
import java.math.BigDecimal

class CurrencyMapper {
    fun mapSupportedCurrencies(response: SupportedCurrenciesResponse): List<CurrencyModel> {

        val result: MutableList<CurrencyModel> = mutableListOf()

        response.currencies.forEach { item ->
            result.add(
                CurrencyModel(
                    symbol = item.key,
                    name = item.value
                )
            )
        }

        return result
    }

    fun mapLiveCurrency(response: LiveCurrenciesResponse): Map<String, QuoteModel> {

        val result: HashMap<String, QuoteModel> = hashMapOf()

        response.quotes?.forEach { item ->
            val key = item.key.subSequence(3, 6).toString()
            result[key] = QuoteModel(
                origin = item.key.subSequence(0, 3).toString(),
                target = key,
                factor = BigDecimal(item.value)
            )
        }

        return result
    }
}