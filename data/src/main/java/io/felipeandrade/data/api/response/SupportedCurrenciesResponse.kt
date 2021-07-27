package io.felipeandrade.data.api.response

data class SupportedCurrenciesResponse(
    val success: Boolean,
    val privacy: String,
    val terms: String,
    val currencies: HashMap<String, String>
)

