package com.btgpactual.data.remote.model

data class LiveResponse(
    val success : Boolean,
    val terms : String?,
    val privacy : String?,
    val timeStamp : String?,
    val source : String?,
    val quotes : QuotePayload,
    val error: ErrorPayload?
)