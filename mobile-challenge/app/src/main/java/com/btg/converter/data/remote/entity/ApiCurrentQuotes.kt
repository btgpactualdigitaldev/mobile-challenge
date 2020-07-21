package com.btg.converter.data.remote.entity

import com.btg.converter.domain.entity.quote.CurrentQuotes
import com.btg.converter.domain.entity.quote.Quote
import com.google.gson.annotations.SerializedName

data class ApiCurrentQuotes(
    @SerializedName("success") val success: Boolean,
    @SerializedName("terms") val terms: String,
    @SerializedName("privacy") val privacy: String,
    @SerializedName("timestamp") val timestamp: Long,
    @SerializedName("source") val sourceCurrencyCode: String,
    @SerializedName("quotes") val quotes: HashMap<String, Double>
) {

    fun toDomainObject() = CurrentQuotes(
        success = success,
        quotes = quotes.map {
            Quote(
                it.key.removePrefix(sourceCurrencyCode),
                it.value
            )
        }
    )
}