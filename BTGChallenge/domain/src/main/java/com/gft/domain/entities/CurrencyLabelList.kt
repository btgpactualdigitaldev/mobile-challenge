package com.gft.domain.entities

data class CurrencyLabelList(
    val success: Boolean? = null,
    val terms: String? = null,
    val privacy: String? = null,
    val currencies: Map<String, String>? = null
)