package io.felipeandrade.data.api.response

data class LiveCurrenciesResponse (
    val success: Boolean,
    val privacy: String,
    val terms: String,
    val timestamp: Int,
    val source: String,
    val quotes: HashMap<String, Double>?
)