package com.example.currencyconverter.remote

import com.google.gson.annotations.Expose
import com.google.gson.annotations.SerializedName

class RateService {

    @SerializedName("success")
    var success: Boolean? = null

    @SerializedName("quotes")
    @Expose
    var mapRates: MutableMap<String, Double>? = null

}