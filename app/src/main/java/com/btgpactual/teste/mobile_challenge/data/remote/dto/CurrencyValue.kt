package com.btgpactual.teste.mobile_challenge.data.remote.dto

import com.squareup.moshi.JsonClass

/**
 * Created by Carlos Souza on 16,October,2020
 */
@JsonClass(generateAdapter = true)
data class CurrencyValue (
    val success: Boolean,
    val terms: String,
    val privacy: String,
    val timestamp: Long,
    val source: String,
    val quotes: Map<String, Double>
)