package br.com.daccandido.currencyconverterapp.data

import br.com.daccandido.currencyconverterapp.data.model.EXCHANGE_RATE_LIST
import br.com.daccandido.currencyconverterapp.data.model.ExchangeRate
import br.com.daccandido.currencyconverterapp.data.model.QuoteRequest
import br.com.daccandido.currencyconverterapp.data.model.REAL_TIME_RATES
import retrofit2.Call
import retrofit2.http.GET
import retrofit2.http.QueryMap


interface RequestAPI {

    @GET( EXCHANGE_RATE_LIST )
    fun getExchangeRate(): Call<ExchangeRate>

    @GET(REAL_TIME_RATES)
    fun getQuote(@QueryMap options: Map<String, String> ) : Call<QuoteRequest>
}