package com.romildosf.currencyconverter.datasource.rest

import com.google.gson.annotations.SerializedName
import org.json.JSONObject

data class CurrencyRest(
    @SerializedName("currencies") val currencies: JSONObject? = null
)