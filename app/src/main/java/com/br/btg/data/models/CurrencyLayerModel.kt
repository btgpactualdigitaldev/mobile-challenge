package com.br.btg.data.models

import com.google.gson.annotations.Expose
import com.google.gson.annotations.SerializedName

data class CurrencyLayerModel(

    @SerializedName("success")
    @Expose
    val success: Boolean? = null,

    @SerializedName("terms")
    @Expose
    val terms: String? = null,

    @SerializedName("privacy")
    @Expose
    val privacy: String? = null,

    @SerializedName("currencies")
    @Expose
    val currencies: Map<String, String>? = null

)

data class  Currency (
    val name: String,
    val value: String
)
