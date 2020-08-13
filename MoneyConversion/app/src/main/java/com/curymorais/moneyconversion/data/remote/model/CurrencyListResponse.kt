package com.curymorais.moneyconversion.data.remote.model

data class CurrencyListResponse(
    val success: Boolean?,
    val terms: String?,
    val privacy: String?,
    val currencies: HashMap<String, String> = HashMap()
)