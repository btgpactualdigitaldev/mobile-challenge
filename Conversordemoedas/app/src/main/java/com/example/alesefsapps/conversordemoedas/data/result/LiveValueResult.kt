package com.example.alesefsapps.conversordemoedas.data.result

import com.example.alesefsapps.conversordemoedas.data.model.Quote

sealed class LiveValueResult {
    class Success(val quotes: List<Quote>, val timestamp: Int) : LiveValueResult()
    class ApiError(val statusCode: Int) : LiveValueResult()
    class SeverError : LiveValueResult()
}