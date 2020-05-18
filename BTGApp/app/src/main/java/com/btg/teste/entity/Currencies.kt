package com.btg.teste.entity

data class Currencies(
    var success: Boolean = false,
    var terms: String = "",
    var privacy: String = "",
    var currencies: Map<String, String> = HashMap()
)