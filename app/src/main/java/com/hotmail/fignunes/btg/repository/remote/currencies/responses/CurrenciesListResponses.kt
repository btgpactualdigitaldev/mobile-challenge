package com.hotmail.fignunes.btg.repository.remote.currencies.responses

import com.hotmail.fignunes.btg.repository.remote.error.ResponseError

data class CurrenciesListResponses (
    var success: Boolean,
    var terms: String,
    var privacy: String,
    var currencies: CurrenciesResponses,
    var error: ResponseError
)