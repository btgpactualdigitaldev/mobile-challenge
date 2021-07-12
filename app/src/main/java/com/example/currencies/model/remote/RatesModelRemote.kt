package com.example.currencies.model.remote

import com.google.gson.annotations.SerializedName

data class RatesModelRemote  (
    @SerializedName("success") val success : Boolean,
    @SerializedName("source") val source : String,
    @SerializedName("quotes") val quotes : Map<String, Double>
)

