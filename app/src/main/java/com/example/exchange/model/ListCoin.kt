package com.example.exchange.model

import com.google.gson.annotations.SerializedName

data class ListCoin(
    @SerializedName("success") val success: Boolean,
    @SerializedName("currencies") val currencies: Map<String, String>
)