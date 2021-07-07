package com.example.alesefsapps.conversordemoedas.data.result

import com.example.alesefsapps.conversordemoedas.data.model.Currency

sealed class CurrencyResult {
    class Success(val currency: List<Currency>) : CurrencyResult()
    class ApiError(val statusCode: Int) : CurrencyResult()
    class SeverError : CurrencyResult()
}