package br.com.btg.mobile.challenge.data.model

import com.squareup.moshi.Json

data class Rate(
    @Json(name = "exchange_rate") val exchangeRate: Double?,
    @Json(name = "coin") val coin: String?
)
