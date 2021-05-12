package com.leonardo.convertcoins.models

data class RealtimeRates(
    val success: Boolean,
    val source: String, // USD
    val quotes: HashMap<String, Double>,
    val error: CurrencyLayerError? = null
)
