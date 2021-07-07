package com.example.alesefsapps.conversordemoedas.data.response

import java.math.BigDecimal

data class LiveCurrencyBodyResponse (
    val success: Boolean,
    val terms: String,
    val privacy: String,
    val timestamp: Int,
    val source: String,
    val quotes: HashMap<String, BigDecimal>?
)