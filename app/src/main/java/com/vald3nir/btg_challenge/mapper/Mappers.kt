package com.vald3nir.btg_challenge.mapper

import com.vald3nir.btg_challenge.items_view.CurrencyItemView
import com.vald3nir.data.database.model.CurrencyView


fun List<CurrencyView>?.toCurrenciesItemView() = this?.map {
    CurrencyItemView(
        url = it.url,
        code = it.code,
        description = it.description,
        usdQuote = it.usdQuote
    )
}

fun CurrencyView?.toCurrencyItemView() = CurrencyItemView(
    url = this?.url,
    code = this?.code,
    description = this?.description,
    usdQuote = this?.usdQuote
)
