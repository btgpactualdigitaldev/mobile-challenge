package com.leonardocruz.btgteste.model

data class CurrencyList(
    val currencies: HashMap<String, String>,
    val success: Boolean
)