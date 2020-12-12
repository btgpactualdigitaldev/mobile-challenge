package com.matheus.conversordemoedas.model

import com.google.gson.annotations.SerializedName

data class CurrencyResult (
    @SerializedName("code") val code : String,
    @SerializedName("description") val description : String
)