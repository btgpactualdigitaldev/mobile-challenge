package com.lucasnav.desafiobtg.modules.currencyConverter.model

data class CurrencyResponse(
    val success: Boolean = false,
    val source: String = "",
    val currencies: Map<String, String>? = null,
    val error: RequestError
)