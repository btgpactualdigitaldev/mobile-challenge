package com.br.mobilechallenge.model


import com.google.gson.annotations.SerializedName

data class ListResponse(
    @SerializedName("currencies")
    val currencies: Map<String, String>,
    @SerializedName("privacy")
    val privacy: String,
    @SerializedName("success")
    val success: Boolean,
    @SerializedName("terms")
    val terms: String
)