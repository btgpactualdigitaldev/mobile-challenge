package com.sugarspoon.data.local.model

import com.sugarspoon.data.remote.model.RealTimeRatesResponse

data class QuotationModel (
    val code: String,
    val value: Float
)

fun RealTimeRatesResponse.toListQuotationModel(): List<QuotationModel>{
    val quotes = mutableListOf<QuotationModel>()
    this.quotes.entries.forEach {
        quotes.add(
            QuotationModel(
                code = it.key.takeLast(3),
                value = it.value
            )
        )
    }
    return quotes
}