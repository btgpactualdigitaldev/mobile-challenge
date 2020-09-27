package com.example.btgconvert.data.response

import com.google.gson.annotations.SerializedName


data class CurrencyListResponse(
        @SerializedName("currencies")
        val currencies: Map<String, String>
)
