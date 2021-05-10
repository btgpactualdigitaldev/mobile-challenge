package com.geocdias.convecurrency.data.network.response

data class CurrencyListResponse(
    val privacy: String,
    val currencies: HashMap<String, String>,
    val source: String,
    val success: Boolean,
    val terms: String
)
