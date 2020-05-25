package com.guioliveiraapps.btg.response

data class CurrencyListResponse(
    var success: Boolean,
    var currencies: Map<String, String>
)