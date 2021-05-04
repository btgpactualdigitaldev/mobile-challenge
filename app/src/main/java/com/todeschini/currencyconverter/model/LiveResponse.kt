package com.todeschini.currencyconverter.model

import com.google.gson.annotations.SerializedName
import java.io.Serializable

data class LiveResponse (
    @SerializedName("success")
    val success: Boolean,
    @SerializedName("terms")
    val terms: String,
    @SerializedName("privacy")
    val privacy: String,
    @SerializedName("timestamp")
    val timestamp: Long,
    @SerializedName("source")
    val source: String,
    @SerializedName("quotes")
    val quotes: Map<String, Double>
): Serializable
