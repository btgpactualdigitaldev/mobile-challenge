package com.vald3nir.data.rest.mapper

import com.vald3nir.data.database.model.Currency
import com.vald3nir.data.database.model.Exchange
import java.util.*

fun Map<String, String>?.toCurrencyList(): ArrayList<Currency> {
    val arrayList = arrayListOf<Currency>()
    this?.map { arrayList.add(Currency(code = it.key, country = it.value)) }
    return arrayList
}

fun Map<String, Double>?.toExchangeList(): ArrayList<Exchange> {
    val arrayList = arrayListOf<Exchange>()
    this?.map { arrayList.add(Exchange(quote = it.key, value = it.value)) }
    return arrayList
}
