package com.guioliveiraapps.btg.response

data class QuoteListResponse(
    var success: Boolean,
    var quotes: Map<String, Double>
)