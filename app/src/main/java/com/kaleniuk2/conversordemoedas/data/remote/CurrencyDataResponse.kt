package com.kaleniuk2.conversordemoedas.data.remote

data class CurrencyDataResponse(
    val success: Boolean,
    val timestamp: Int,
    val quotes: Map<String, String>? = null
)