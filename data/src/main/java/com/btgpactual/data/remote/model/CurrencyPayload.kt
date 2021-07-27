package com.btgpactual.data.remote.model


data class CurrencyPayload(
    val payloads : List<CurrencyModel>
)

data class CurrencyModel(
    val code : String,
    val name : String
)