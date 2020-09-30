package com.btgpactual.currencyconverter.data.framework.retrofit.response

import com.squareup.moshi.JsonClass

@JsonClass(generateAdapter = true)
data class CurrencyListResponse(
    val success: Boolean,
    val currencies: Map<String, String>
)