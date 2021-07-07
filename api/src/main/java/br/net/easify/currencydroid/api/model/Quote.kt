package br.net.easify.currencydroid.api.model

import com.google.gson.annotations.Expose
import com.google.gson.annotations.SerializedName

data class Quote (
    @SerializedName("success")
    @Expose
    val success: Boolean,

    @SerializedName("terms")
    @Expose
    val terms: String,

    @SerializedName("privacy")
    @Expose
    val privacy: String,

    @SerializedName("timestamp")
    @Expose
    val timestamp: Long,

    @SerializedName("source")
    @Expose
    val source: String,

    @SerializedName("quotes")
    @Expose
    val quotes: Map<String, Float>,
)