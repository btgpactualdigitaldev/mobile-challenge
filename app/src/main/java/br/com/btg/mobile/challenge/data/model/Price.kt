package br.com.btg.mobile.challenge.data.model

import com.squareup.moshi.Json
data class Price(
    @Json(name = "price") val price: Double?,
    @Json(name = "coin") val coin: String?
)
