package com.lucasnav.desafiobtg.modules.currencyConverter.model

data class QuoteResponse(
    val success: Boolean = false,
    val source: String = "",
    val quotes: Map<String, Double>? = null,
    val error: RequestError
)