package br.com.btgpactual.currencyconverter.data.retrofit.response

import com.squareup.moshi.JsonClass

@JsonClass(generateAdapter = true)
data class QuotationBodyResponse (
    val success : Boolean,
    val quotes : Map<String,Double>
)