package com.example.currencyconverter.infrastructure.network

data class ListAPIResponseModel(
    var success: Boolean = false,
    var terms: String = "",
    var privacy: String = "",
    var currencies: Map<String,String> = emptyMap()
)

