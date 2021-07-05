package com.example.currencyconverter.remote

import com.google.gson.annotations.Expose
import com.google.gson.annotations.SerializedName

class CurrencyListService {
    @SerializedName("success")
    var success: Boolean? = null

    @SerializedName("currencies")
    @Expose
    var mapCurrencies: MutableMap<String, String>? = null
}