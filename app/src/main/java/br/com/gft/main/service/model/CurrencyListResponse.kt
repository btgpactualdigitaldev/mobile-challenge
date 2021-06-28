package br.com.gft.main.service.model

data class CurrencyListResponse(
    val currencies: HashMap<String, String>,
    val privacy: String,
    val success: Boolean,
    val terms: String
)

