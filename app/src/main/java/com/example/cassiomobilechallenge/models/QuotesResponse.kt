package com.example.cassiomobilechallenge.models

import com.google.gson.annotations.Expose
import com.google.gson.annotations.SerializedName

data class QuotesResponse(

    @SerializedName("success")
    @Expose
    var success: Boolean,

    @SerializedName("terms")
    @Expose
    var terms: String,

    @SerializedName("privacy")
    @Expose
    var privacy: String,

    @SerializedName("timestamp")
    @Expose
    var timestamp: Int,

    @SerializedName("source")
    @Expose
    var source: String,

    @SerializedName("quotes")
    @Expose
    var quotes: HashMap<String, Double>

)