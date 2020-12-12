package com.matheus.conversordemoedas.model

import com.google.gson.annotations.SerializedName

data class CurrencyJson (
    @SerializedName("success") val success : Boolean,
    @SerializedName("terms") val terms : String,
    @SerializedName("privacy") val privacy : String,
    @SerializedName("currencies") val currencies : Currency
)