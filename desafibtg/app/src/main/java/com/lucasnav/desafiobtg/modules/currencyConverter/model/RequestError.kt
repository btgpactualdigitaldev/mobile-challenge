package com.lucasnav.desafiobtg.modules.currencyConverter.model

data class RequestError(
    val code: Int = -1,
    val info: String
)