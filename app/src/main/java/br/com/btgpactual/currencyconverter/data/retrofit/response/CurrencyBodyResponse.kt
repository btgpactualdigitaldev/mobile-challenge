package br.com.btgpactual.currencyconverter.data.retrofit.response

import com.squareup.moshi.JsonClass

@JsonClass(generateAdapter = true)
data class CurrencyBodyResponse(
    val success: Boolean,
    val currencies: Map<String, String>
)