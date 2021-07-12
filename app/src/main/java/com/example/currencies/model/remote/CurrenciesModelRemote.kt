package com.example.currencies.model.remote

import com.google.gson.annotations.SerializedName

class CurrenciesModelRemote(
    @SerializedName("success") var success: Boolean,
    @SerializedName("currencies") var currencies: Map<String, String>
)

