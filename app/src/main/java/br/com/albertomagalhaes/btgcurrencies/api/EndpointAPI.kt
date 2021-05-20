package com.btgpactual.currencyconverter.data.framework.retrofit

import br.com.albertomagalhaes.btgcurrencies.Constant.Companion.KEY
import com.btgpactual.currencyconverter.data.framework.retrofit.response.CurrencyListResponse
import com.btgpactual.currencyconverter.data.framework.retrofit.response.QuoteListResponse
import retrofit2.Call
import retrofit2.http.GET
import retrofit2.http.Query

interface EndpointAPI {
    @GET("list")
    fun getCurrencyList(
        @Query("access_key") key: String = KEY
    ): Call<CurrencyListResponse>

    @GET("live")
    fun getQuoteList(
        @Query("access_key") key: String = KEY
    ): Call<QuoteListResponse>

}