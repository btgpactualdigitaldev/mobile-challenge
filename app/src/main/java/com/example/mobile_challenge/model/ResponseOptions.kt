package com.example.mobile_challenge.model

sealed class ResponseOptionsCurrency {
  data class SuccessResponse(val data: CurrencyResponse) : ResponseOptionsCurrency()
  data class ErrorResponse(val message: String) : ResponseOptionsCurrency()
}

sealed class ResponseOptionsQuote {
  data class SuccessResponse(val data: QuoteResponse) : ResponseOptionsQuote()
  data class ErrorResponse(val message: String) : ResponseOptionsQuote()
}

