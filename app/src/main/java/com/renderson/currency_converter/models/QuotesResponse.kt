package com.renderson.currency_converter.models

import com.google.gson.annotations.SerializedName

data class QuotesResponse(
    @SerializedName("success")
    val success: Boolean,
    @SerializedName("terms")
    val terms: String,
    @SerializedName("privacy")
    val privacy: String,
    @SerializedName("timestamp")
    val timestamp: Int,
    @SerializedName("source")
    val source: String,
    @SerializedName("quotes")
    val quotes: Map<String, String>
)