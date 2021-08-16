package com.br.cambio.data.model

import com.google.gson.annotations.Expose
import java.io.Serializable

data class Exchange(
    val success: Boolean,
    @Expose
    val currencies: HashMap<String, String>,
    @Expose
    val quotes: HashMap<String, Double>,
    val source: String
): Serializable