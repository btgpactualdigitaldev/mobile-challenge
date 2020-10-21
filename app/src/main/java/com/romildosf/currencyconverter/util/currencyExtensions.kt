package com.romildosf.currencyconverter.util

import com.romildosf.currencyconverter.dao.Currency

fun List<Currency>.asMap(): Map<String, Currency> {
    val map = mutableMapOf<String, Currency>()
    this.forEach { map[it.symbol] = it }
    return map
}