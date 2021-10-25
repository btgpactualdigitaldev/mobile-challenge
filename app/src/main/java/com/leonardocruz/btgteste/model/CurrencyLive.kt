package com.leonardocruz.btgteste.model

data class CurrencyLive(
    val quotes: HashMap<String, String>,
    val source: String,
    val success: Boolean
)