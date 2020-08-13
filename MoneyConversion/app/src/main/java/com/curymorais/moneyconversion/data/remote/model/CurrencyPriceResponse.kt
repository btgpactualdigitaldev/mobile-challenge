package com.curymorais.moneyconversion.data.remote.model

import java.math.BigDecimal

data class CurrencyPriceResponse(
    val success: Boolean?=null,
    val terms: String?=null,
    val privacy: String?=null,
    val timestamp: Int?=null,
    val source: String?=null,
    val quotes: HashMap<String, BigDecimal?> = HashMap()
)