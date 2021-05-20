package com.renderson.currency_converter.models

import com.google.gson.annotations.SerializedName

data class CurrencyResponse (
    @SerializedName("success")
    val success: Boolean,
    @SerializedName("currencies")
    val currencies: Map<String, String>,
    @SerializedName("terms")
    val terms: String,
    @SerializedName("privacy")
    val privacy: String
)