package br.net.easify.currencydroid.api.model

import com.google.gson.annotations.Expose
import com.google.gson.annotations.SerializedName

data class Currency (

    @SerializedName("success")
    @Expose
    val success: Boolean,

    @SerializedName("terms")
    @Expose
    val terms: String,

    @SerializedName("privacy")
    @Expose
    val privacy: String,

    @SerializedName("currencies")
    @Expose
    val currencies: Map<String, String>,
)