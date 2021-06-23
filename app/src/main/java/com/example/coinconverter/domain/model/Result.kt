package com.example.coinconverter.domain.model

import com.google.gson.annotations.Expose
import java.io.Serializable

data class Result(
    val success: Boolean,
    @Expose
    val currencies: HashMap<String, String>,
    @Expose
    val quotes: HashMap<String, Double>,
    val source: String
): Serializable