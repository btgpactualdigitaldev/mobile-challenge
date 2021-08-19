package com.example.challengesavio.api.models

import com.google.gson.annotations.SerializedName
import java.io.Serializable
import com.google.gson.annotations.Expose

class CurrenciesOutputs(
    @SerializedName("currencies")
    @Expose
    var currencies: Map<String, String>? = null
) : Serializable

