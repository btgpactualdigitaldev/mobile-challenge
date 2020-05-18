package com.btg.teste.entity

data class CurrencyLayer(
    var success: Boolean = false,
    var terms: String = "",
    var privacy: String = "",
    var timestamp: Int = 0,
    var source: String = "",
    var quotes: Map<String, Double> = HashMap()
)