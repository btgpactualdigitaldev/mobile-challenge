package br.com.daccandido.currencyconverterapp.data

import br.com.daccandido.currencyconverterapp.data.model.ExchangeRate
import br.com.daccandido.currencyconverterapp.data.model.QuoteRequest

sealed class ResultRequest {
    class SuccessExchangeRate (val exchangeRate: ExchangeRate): ResultRequest()
    class SuccessQuote (val quoteRequest: QuoteRequest): ResultRequest()
    class Error(val error: Int): ResultRequest()
    object SeverError: ResultRequest()
}