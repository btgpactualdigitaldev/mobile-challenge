package com.example.challengecpqi.model.response

import com.example.challengecpqi.model.Currency

data class CurrencyResponse (
    val success: Boolean,
    val terms: String,
    val privacy: String,
    var currencies: List<Currency>
)