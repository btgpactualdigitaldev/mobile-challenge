package com.romildosf.currencyconverter.util

import com.romildosf.currencyconverter.dao.Quotation

fun List<Quotation>.asMap(): Map<String, Quotation> {
    val map = mutableMapOf<String, Quotation>()
    this.forEach { map[it.pair] = it }
    return map
}
