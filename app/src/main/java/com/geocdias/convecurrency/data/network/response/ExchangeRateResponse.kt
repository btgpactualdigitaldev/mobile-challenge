package com.geocdias.convecurrency.data.network.response

data class ExchangeRateResponse(
    val privacy: String,
    val quotes: HashMap<String, String>,
    val source: String,
    val success: Boolean,
    val terms: String,
    val timestamp: Int
)

