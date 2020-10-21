package com.romildosf.currencyconverter.datasource.rest

import com.google.gson.JsonObject
import com.google.gson.annotations.SerializedName
import com.romildosf.currencyconverter.dao.Quotation

open class QuotesListResponse {
    @SerializedName("quotes") private val raw: JsonObject? = null
    @SerializedName("success") val success: Boolean = true
    @SerializedName("error") val error: DefaultErrorResponse? = null

    val quotes: List<Quotation>
        get() {
            return raw?.entrySet()?.map {
                Quotation(it.key, it.value.asDouble)
            } ?: emptyList()
        }
}