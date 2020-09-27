package com.example.btgconvert.data.response

import com.google.gson.annotations.SerializedName


data class QuotesResponce(
        @SerializedName("quotes")
        val quotes: Map<String,Double>
)