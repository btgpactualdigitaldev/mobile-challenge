package com.example.desafiobtg.model.liveprice

import com.google.gson.annotations.SerializedName

data class LivePriceModel(
        @SerializedName("success")
        val success: Boolean,
        @SerializedName("source")
        val source: String,
        @SerializedName("quotes")
        var livePrice: Map<String, Double>?
)
