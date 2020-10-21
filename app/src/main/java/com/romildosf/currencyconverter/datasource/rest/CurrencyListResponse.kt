package com.romildosf.currencyconverter.datasource.rest

import com.google.gson.JsonObject
import com.google.gson.annotations.SerializedName
import com.romildosf.currencyconverter.dao.Currency

open class CurrencyListResponse {
    @SerializedName("currencies") private val raw: JsonObject? = null
    @SerializedName("success") val success: Boolean = true
    @SerializedName("error") val error: DefaultErrorResponse? = null

    val currencies: List<Currency>
        get() {
            return raw?.entrySet()?.map {
                Currency(it.key, it.value.asString)
            } ?: emptyList()
        }
}