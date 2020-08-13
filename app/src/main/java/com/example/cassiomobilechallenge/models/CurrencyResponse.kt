package com.example.cassiomobilechallenge.models

import com.google.gson.annotations.Expose
import com.google.gson.annotations.SerializedName

data class CurrencyResponse(

    @SerializedName("success")
    @Expose
    var success: Boolean,

    @SerializedName("terms")
    @Expose
    var terms: String,

    @SerializedName("privacy")
    @Expose
    var privacy: String,

    @SerializedName("currencies")
    @Expose
    var currencies: HashMap<String, String>

)