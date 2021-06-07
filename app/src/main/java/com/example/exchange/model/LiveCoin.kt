package com.example.exchange.model

import com.google.gson.annotations.SerializedName

data class LiveCoin(
    @SerializedName("success") val success: Boolean,
    @SerializedName("source") val source: String,
    @SerializedName("quotes") val quotes: Map<String, Double>
)