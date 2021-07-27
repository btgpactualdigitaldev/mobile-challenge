package com.btgpactual.data.remote.model

data class ListResponse(
    val success : Boolean,
    val terms : String?,
    val privacy : String?,
    val currencies : CurrencyPayload,
    val error : ErrorPayload?
)