package br.com.tiago.conversormoedas.data.response

import com.squareup.moshi.Json
import com.squareup.moshi.JsonClass

@JsonClass(generateAdapter = true)
class ConversorBodyResponse(
    @Json(name = "success")
    val success: Boolean,
    @Json(name = "terms")
    val terms: String,
    @Json(name = "privacy")
    val privacy: String,
    @Json(name = "timestamp")
    val timestamp: Long,
    @Json(name = "source")
    val source: String,
    @Json(name = "quotes")
    val quotes: Map<String, Float>
)