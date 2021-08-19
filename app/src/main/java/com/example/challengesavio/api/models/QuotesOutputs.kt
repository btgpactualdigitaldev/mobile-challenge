package com.example.challengesavio.api.models

import com.google.gson.annotations.SerializedName
import java.io.Serializable
import com.google.gson.annotations.Expose

class QuotesOutputs(
    @SerializedName("quotes")
    @Expose
    var quotes: HashMap<String, Double>? = null
) : Serializable

