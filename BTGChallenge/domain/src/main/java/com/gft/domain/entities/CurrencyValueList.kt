package com.gft.domain.entities

data class CurrencyValueList(
    val success: Boolean? = null,
    val terms: String? = null,
    val privacy: String? = null,
    var source: String? = null,
    val quotes: Map<String, String>? = null
)