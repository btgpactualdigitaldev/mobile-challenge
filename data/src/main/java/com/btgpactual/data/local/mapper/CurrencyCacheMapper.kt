package com.btgpactual.data.local.mapper

import com.btgpactual.data.local.model.CurrencyCache
import com.btgpactual.domain.entity.Currency

object CurrencyCacheMapper {
    fun map(cacheData : List<CurrencyCache>) = cacheData.map{map(it)}

    private fun map(cache: CurrencyCache) = Currency(
        code = cache.code,
        name = cache.name
    )

    fun mapCurrencyToCurrencyCache(currencies: List<Currency>) = currencies.map { map(it) }

    private fun map(currency: Currency) = CurrencyCache(
        code = currency.code,
        name = currency.name

    )
}