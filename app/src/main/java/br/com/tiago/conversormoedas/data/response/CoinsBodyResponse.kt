package br.com.tiago.conversormoedas.data.response

import com.squareup.moshi.Json
import com.squareup.moshi.JsonClass

@JsonClass(generateAdapter = true)
class CoinsBodyResponse(
    @Json(name = "success")
    val success: Boolean,
    @Json(name = "terms")
    val terms: String,
    @Json(name = "privacy")
    val privacy: String,
    @Json(name = "currencies")
    val currencies: Map<String, String>
)