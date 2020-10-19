package com.btgpactual.teste.mobile_challenge.data.remote.dto

import com.squareup.moshi.JsonClass

/**
 * Created by Carlos Souza on 16,October,2020
 */
@JsonClass(generateAdapter = true)
data class CurrencyList (
    val success: Boolean,
    val terms: String,
    val privacy: String,
    val currencies: Map<String, String>
)