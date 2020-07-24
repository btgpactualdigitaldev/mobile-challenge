package com.desafio.btgpactual.http.responses

data class CurrencyResponse(
    val success: Boolean,
    val terms: String,
    val privacy: String,
    val currencies: HashMap<String, String>
)