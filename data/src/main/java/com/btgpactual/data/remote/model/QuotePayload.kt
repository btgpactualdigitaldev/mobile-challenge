package com.btgpactual.data.remote.model

data class QuotePayload(
    val payloads : List<QuoteModel>
)

data class QuoteModel(
    val code : String,
    val value : Double
)