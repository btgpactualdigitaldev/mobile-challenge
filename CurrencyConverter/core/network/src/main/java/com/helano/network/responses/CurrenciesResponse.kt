package com.helano.network.responses

data class CurrenciesResponse(
    val success: Boolean,
    val terms: String,
    val privacy: String,
    val currencies: Map<String, String>
)