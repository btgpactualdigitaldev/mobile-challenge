package br.com.daccandido.currencyconverterapp.data.repository

import br.com.daccandido.currencyconverterapp.data.ResultRequest

interface CurrencyRepository {

    suspend fun getListExchangeRate(callback: (result: ResultRequest) -> Unit)

    suspend fun getAllQuote(callback: (result: ResultRequest) -> Unit)

    suspend fun getQuote(currenciyes: String, callback: (result: ResultRequest) -> Unit)
}