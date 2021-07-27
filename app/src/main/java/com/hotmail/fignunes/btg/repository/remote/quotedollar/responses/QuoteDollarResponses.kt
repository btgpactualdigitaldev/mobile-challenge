package com.hotmail.fignunes.btg.repository.remote.quotedollar.responses

import com.hotmail.fignunes.btg.repository.remote.error.ResponseError

data class QuoteDollarResponses (
    var success: Boolean,
    var terms: String,
    var privacy: String,
    var timestamp: Long,
    var source: String,
    var quotes: QuotesResponses,
    var error: ResponseError
)